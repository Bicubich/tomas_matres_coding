import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/cart_product_model.dart';

part 'cart_view_quantity_state.dart';

class CartViewQuantityCubit extends Cubit<CartViewQuantityState> {
  final CartProduct cartProduct;
  final CartCubit cartCubit;

  CartViewQuantityCubit({required this.cartProduct, required this.cartCubit})
      : super(const CartViewQuantityState(
          itemCount: 0,
        )) {
    _init();
  }

  int itemCount = 0;

  void _init() {
    itemCount = cartProduct.quantity;
    emit(CartViewQuantityState(
      itemCount: itemCount,
    ));
  }

  void increase() {
    itemCount++;
    cartCubit.changeQuantity(cartProduct.copyWith(quantity: itemCount));
    emit(CartViewQuantityState(
      itemCount: itemCount,
    ));
  }

  void decrease() {
    if (itemCount > 1) {
      itemCount--;
      cartCubit.changeQuantity(cartProduct.copyWith(quantity: itemCount));
      emit(CartViewQuantityState(
        itemCount: itemCount,
      ));
    }
  }
}
