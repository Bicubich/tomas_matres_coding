part of 'cart_order_dialog_cubit.dart';

sealed class CartOrderDialogState extends Equatable {
  const CartOrderDialogState();

  @override
  List<Object> get props => [];
}

final class CartOrderDialogSuccessState extends CartOrderDialogState {
  final String orderNumber;

  const CartOrderDialogSuccessState({required this.orderNumber});

  @override
  List<Object> get props => [orderNumber];
}

final class CartOrderDialogLoadingState extends CartOrderDialogState {}

final class CartOrderDialogErrorState extends CartOrderDialogState {}
