import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/api/api.dart';
import 'package:tomas_matres/data_models/order/order_model.dart';
import 'package:tomas_matres/shared_cubits/customer/customer_cubit.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/data/cart_event_model.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/cart_product_model.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/success_order_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CustomerCubit customerCubit;

  CartCubit({
    required this.customerCubit,
  }) : super(const CartLoading(totalCount: 0)) {
    init();
  }

  StreamController<CartEvent> cartEventsStreamController =
      StreamController<CartEvent>.broadcast();
  List<CartProduct> cartProducts = [];
  double totalToPay = 0;
  double totalToPayWithSale = 0;
  double totalSale = 0;
  int totalCount = 0;
  late String customerId;

  Future<void> init() async {
    customerId = customerCubit.customerId ?? '';

    cartProducts = await TomasApi.getCart(customerId);

    if (cartProducts.isNotEmpty) {
      List<Future> futures = [];

      for (int i = 0; i < cartProducts.length; i++) {
        futures.add(TomasApi.getProduct(cartProducts[i].productId));
      }

      List<Product> products = [];

      await Future.wait(futures).then((value) {
        for (Product product in value) {
          products.add(product);
        }
      });

      for (int i = 0; i < cartProducts.length; i++) {
        Product product = products
            .firstWhere((element) => element.id == cartProducts[i].productId);

        cartProducts[i] = cartProducts[i].copyWith(product: product);
      }

      _calculateTotals();

      emit(CartLoaded(
          totalToPay: totalToPay,
          totalToPayWithSale: totalToPayWithSale,
          totalSale: totalSale,
          cartProducts: cartProducts,
          totalCount: cartProducts.length));
    } else {
      emit(CartNoData());
    }
  }

  Future<void> addToCart(Product product,
      {Map<String, dynamic>? options}) async {
    emit(CartLoading(totalCount: totalCount));

    await TomasApi.addToCart(
        customerId: customerId,
        productId: product.id,
        quantity: 1,
        options: options);
    await init();

    CartProduct cartProduct =
        cartProducts.firstWhere((element) => element.productId == product.id);

    cartEventsStreamController
        .add(CartEvent(CartEventType.addItem, product: cartProduct));
  }

  Future<void> changeQuantity(CartProduct cartProduct) async {
    int productIndex = cartProducts
        .indexWhere((element) => element.cartId == cartProduct.cartId);
    cartProducts[productIndex] = cartProduct;
    _calculateTotals();
    await TomasApi.editCartQuantity(
        customerId: customerId, product: cartProduct);
    emit(CartLoaded(
        totalToPay: totalToPay,
        totalToPayWithSale: totalToPayWithSale,
        totalSale: totalSale,
        cartProducts: cartProducts,
        totalCount: cartProducts.length));
  }

  Future<void> removeFromCart(CartProduct cartProduct) async {
    emit(CartLoading(totalCount: totalCount));
    cartProducts.removeWhere((element) => element.cartId == cartProduct.cartId);
    _calculateTotals();
    await TomasApi.removeFromCart(customerId: customerId, product: cartProduct);
    if (cartProducts.isEmpty) {
      emit(CartNoData());
    } else {
      emit(CartLoaded(
          totalToPay: totalToPay,
          totalToPayWithSale: totalToPayWithSale,
          totalSale: totalSale,
          cartProducts: cartProducts,
          totalCount: cartProducts.length));
    }

    cartEventsStreamController
        .add(CartEvent(CartEventType.removeItem, product: cartProduct));
  }

  Future<void> clearCart() async {
    emit(CartLoading(totalCount: totalCount));

    List<Future> futures = [];

    for (CartProduct element in cartProducts) {
      futures.add(
          TomasApi.removeFromCart(customerId: customerId, product: element));
    }

    await Future.wait(futures);

    cartProducts.clear();

    _calculateTotals();

    cartEventsStreamController.add(CartEvent(CartEventType.removeAll));

    emit(CartNoData());
  }

  Future<SuccessOrder> createOrder(
      {required Address address,
      required String email,
      required String phone,
      String comment = ''}) async {
    await customerCubit.edit(
        firstname: address.firstname,
        lastname: address.lastname,
        email: email,
        phone: phone);

    List<OrderTotal> totals = [
      OrderTotal(
          code: 'sub_total',
          title: "Sub-Total",
          value: totalToPay,
          sortOrder: "1"),
      OrderTotal(
          code: 'total',
          title: "Total",
          value: totalToPayWithSale > 0 ? totalToPayWithSale : totalToPay,
          sortOrder: "2"),
    ];

    Order order = Order(
        customer: customerCubit.customer,
        paymentAddress: address,
        paymentMethod: PaymentMethod(),
        shippingAddress: address,
        products: List.generate(cartProducts.length,
            (index) => OrderProduct.fromCartProduct(cartProducts[index])),
        comment: comment,
        total: totalToPay,
        totals: totals);

    SuccessOrder successOrder = await TomasApi.createOrder(order);

    return successOrder;
  }

  void _calculateTotals() {
    totalToPay = 0;
    totalToPayWithSale = 0;
    totalSale = 0;
    double optionsTotal = 0;
    totalCount = cartProducts.length;

    for (int i = 0; i < totalCount; i++) {
      if (cartProducts[i].product != null) {
        Product product = cartProducts[i].product!;

        CartProduct cartProduct = cartProducts[i].copyWith(product: product);
        cartProducts[i] = cartProduct;

        cartProduct.selectedOptionsIds.forEach((key, value) {
          if (value.runtimeType == List<dynamic>) {
            for (String selectedOptionValue in value) {
              Option option = product.options
                  .firstWhere((element) => element.productOptionId == key);
              ProductOptionValue optionValue = option.productOptionValue
                  .firstWhere((element) =>
                      element.productOptionValueId == selectedOptionValue);
              if (optionValue.pricePrefix == '+') {
                optionsTotal = optionsTotal + double.parse(optionValue.price);
              } else {
                optionsTotal = optionsTotal - double.parse(optionValue.price);
              }
            }
          }
          if (value.runtimeType == String) {
            Option option = product.options
                .firstWhere((element) => element.productOptionId == key);
            ProductOptionValue optionValue = option.productOptionValue
                .firstWhere((element) => element.productOptionValueId == value);
            if (optionValue.pricePrefix == '+') {
              optionsTotal = optionsTotal + double.parse(optionValue.price);
            } else {
              optionsTotal = optionsTotal - double.parse(optionValue.price);
            }
          }
        });

        totalToPay =
            totalToPay + (product.price * cartProduct.quantity) + optionsTotal;

        totalToPayWithSale = totalToPayWithSale +
            (product.specialPrice != null
                ? product.specialPrice!
                : product.price * cartProduct.quantity) +
            optionsTotal;
        totalSale = totalToPay - totalToPayWithSale;
      } else {
        throw 'Error: No product in cart product (_calculateTotals)';
      }
    }
  }

  @override
  Future<void> close() {
    cartEventsStreamController.close();
    return super.close();
  }
}
