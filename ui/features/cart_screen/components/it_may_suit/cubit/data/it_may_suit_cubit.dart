import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/api/api.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/data/cart_event_model.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/cart_product_model.dart';
import 'package:tomas_matres/ui/features/main_screen/cubit/main_screen_cubit.dart';

part 'it_may_suit_state.dart';

class ItMaySuitCubit extends Cubit<ItMaySuitState> {
  final CartCubit cartCubit;
  final MainScreenCubit mainScreenCubit;

  ItMaySuitCubit({required this.cartCubit, required this.mainScreenCubit})
      : super(ItMaySuitLoading()) {
    _init();
  }

  StreamSubscription<CartState>? cartCubitStreamSubscription;
  late StreamSubscription<CartEvent> cartEventsStreamSubscription;

  List<Product> itMaySuitProducts = [];
  List<String> usedModels = [];

  bool initialized = false;

  Future<void> _init() async {
    if (cartCubit.state is CartLoading) {
      // Ждем пока загрузится корзина
      cartCubitStreamSubscription = cartCubit.stream.listen((cartState) async {
        if (cartState is! CartLoading) {
          _setup();
        }
      });
    } else {
      // Если корзина уже загружена
      _setup();
    }
  }

  Future<void> _setup() async {
    usedModels.clear();
    itMaySuitProducts.clear();

    for (CartProduct cartProduct in cartCubit.cartProducts) {
      Product product = await _getProductFromCartProduct(
          cartProduct); // Получаем Product из CartProduct

      if (!usedModels.contains(product.model)) {
        // Проверяем не добавлена ли эта модель в корзину
        List<Product> productsByManufacturer =
            await TomasApi.getProductsByManufacture(product.manufacturerId ??
                ''); // Получаем список товаров такого же производителя

        productsByManufacturer.removeWhere((element) =>
            element.id ==
            product.id); // Удаляем из списка товар, который уже в корзине

        List<Product> productsByCartProductModel = productsByManufacturer
            .where((element) => element.model == product.model)
            .toList(); // Создаем список из товаров которые той же модели, что и товар из корзины

        itMaySuitProducts
            .addAll(productsByCartProductModel); // Добавляем товары в список

        usedModels.add(product.model ??
            ''); // Добавляем модель в список добавленных моделей, чтобы не использовать ее больше
      }
    }

    cartEventsStreamSubscription =
        cartCubit.cartEventsStreamController.stream.listen((event) {
      if (event.event == CartEventType.addItem) {
        if (event.product != null) {
          onCartProductAdd(event.product!);
        }
        return;
      }

      if (event.event == CartEventType.removeItem) {
        if (event.product != null) {
          onCartProductRemove(event.product!);
        }
        return;
      }

      if (event.event == CartEventType.removeAll) {
        onCartClear();
        return;
      }
    });

    initialized = true;

    if (cartCubit.state is CartNoData || itMaySuitProducts.isEmpty) {
      // Если пустая корзина, то стейт делаем NoData
      emit(ItMaySuitNoData());
      return;
    }

    itMaySuitProducts.shuffle(); // Перемешиваем

    emit(ItMaySuitLoaded(
        itMaySuitProducts: itMaySuitProducts,
        countOfProducts: itMaySuitProducts.length));

    if (cartCubitStreamSubscription != null) {
      cartCubitStreamSubscription!.cancel();
    }
  }

  Future<void> onCartProductAdd(CartProduct cartProduct) async {
    emit(ItMaySuitLoading());
    Product product = await _getProductFromCartProduct(
        cartProduct); // Получаем Product из CartProduct

    if (usedModels.isNotEmpty && usedModels.contains(product.model)) {
      // Проверяем добавлена ли эта модель в корзину
      itMaySuitProducts
          .shuffle(); // Если добавлена то просто перемешиваем товары и применяем стейт
      emit(ItMaySuitLoaded(
          itMaySuitProducts: itMaySuitProducts,
          countOfProducts: itMaySuitProducts.length));
      return;
    }

    List<Product> productsByManufacturer =
        await TomasApi.getProductsByManufacture(product.manufacturerId ??
            ''); // Получаем список товаров такого же производителя

    productsByManufacturer.removeWhere((element) =>
        element.id ==
        product.id); // Удаляем из списка товар, который уже в корзине

    List<Product> productsByCartProductModel = productsByManufacturer
        .where((element) => element.model == product.model)
        .toList(); // Создаем список из товаров которые той же модели, что и товар из корзины

    itMaySuitProducts
        .addAll(productsByCartProductModel); // Добавляем товары в список

    usedModels.add(product.model ??
        ''); // Добавляем модель в список добавленных моделей, чтобы не использовать ее больше

    itMaySuitProducts.shuffle(); // Перемешиваем

    if (itMaySuitProducts.isNotEmpty) {
      emit(ItMaySuitLoaded(
          itMaySuitProducts: itMaySuitProducts,
          countOfProducts: itMaySuitProducts.length));
    } else {
      emit(ItMaySuitNoData());
    }
  }

  Future<void> onCartProductRemove(CartProduct cartProduct) async {
    emit(ItMaySuitLoading());
    Product product = await _getProductFromCartProduct(
        cartProduct); // Получаем Product из CartProduct

    for (CartProduct cartProduct in cartCubit.cartProducts) {
      Product productFormCartProduct =
          await _getProductFromCartProduct(cartProduct);

      if (cartCubit.cartProducts
          .any((element) => productFormCartProduct.model == product.model)) {
        // Проверяем есть ли в корзине товары с такой же моделью. Если есть, то нам не нужно удалять предложенные товары.
        itMaySuitProducts.shuffle(); // Перемешиваем

        emit(ItMaySuitLoaded(
            itMaySuitProducts: itMaySuitProducts,
            countOfProducts: itMaySuitProducts.length));

        return;
      }
    }

    itMaySuitProducts.removeWhere((element) =>
        element.model ==
        product.model); // Удаляем все предложенные товары с такой же моделью

    usedModels.remove(product.model); // Удаляем модель из списка использованных

    if (itMaySuitProducts.isNotEmpty) {
      itMaySuitProducts.shuffle(); // Перемешиваем

      emit(ItMaySuitLoaded(
          itMaySuitProducts: itMaySuitProducts,
          countOfProducts: itMaySuitProducts.length));
    } else {
      emit(ItMaySuitNoData());
    }
  }

  void onCartClear() {
    emit(ItMaySuitLoading());

    itMaySuitProducts.clear();
    usedModels.clear();

    emit(ItMaySuitNoData());
  }

  Future<Product> _getProductFromCartProduct(CartProduct cartProduct) async {
    late Product product;
    if (cartProduct.product != null) {
      // Если у cart product указано его представление в качестве Product объекта
      product = cartProduct.product!;
    } else {
      // В противном случае берем Product из всех товаров
      Product? result = await TomasApi.getProduct(cartProduct.productId);
      if (result != null) {
        product = result;
      } else {
        throw 'No product by id ${cartProduct.productId}';
      }
    }

    return product;
  }

  @override
  Future<void> close() {
    cartEventsStreamSubscription.cancel();
    return super.close();
  }
}
