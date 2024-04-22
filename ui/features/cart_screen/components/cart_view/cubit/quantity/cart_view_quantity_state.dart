part of 'cart_view_quantity_cubit.dart';

class CartViewQuantityState extends Equatable {
  final int itemCount;

  const CartViewQuantityState({required this.itemCount});

  @override
  List<Object> get props => [itemCount];

  CartViewQuantityState copyWith({int? itemCount}) {
    return CartViewQuantityState(
      itemCount: itemCount ?? this.itemCount,
    );
  }
}
