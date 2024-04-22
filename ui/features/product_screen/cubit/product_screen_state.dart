part of 'product_screen_cubit.dart';

sealed class ProductScreenState extends Equatable {
  const ProductScreenState();

  @override
  List<Object> get props => [];
}

final class ProductScreenLoading extends ProductScreenState {}

final class ProductScreenLoaded extends ProductScreenState {
  final Product product;

  const ProductScreenLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

final class ProductScreenError extends ProductScreenState {}

final class ProductScreenErrorNotFound extends ProductScreenState {}
