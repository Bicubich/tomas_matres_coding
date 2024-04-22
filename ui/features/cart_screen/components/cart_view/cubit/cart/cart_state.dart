part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartLoading extends CartState {
  final int totalCount;

  const CartLoading({required this.totalCount});

  @override
  List<Object> get props => [totalCount];
}

final class CartLoaded extends CartState {
  final List<CartProduct> cartProducts;
  final int totalCount;
  final double totalToPay;
  final double totalToPayWithSale;
  final double totalSale;

  const CartLoaded({
    required this.totalToPay,
    required this.totalToPayWithSale,
    required this.totalSale,
    required this.cartProducts,
    required this.totalCount,
  });

  @override
  List<Object> get props =>
      [cartProducts, totalToPay, totalToPayWithSale, totalSale, totalCount];
}

final class CartNoData extends CartState {}
