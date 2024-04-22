part of 'product_info_option_error_cubit.dart';

sealed class ProductInfoOptionErrorState extends Equatable {
  const ProductInfoOptionErrorState();

  @override
  List<Object> get props => [];
}

final class ProductInfoOptionErrorHidden extends ProductInfoOptionErrorState {}

final class ProductInfoOptionErrorShown extends ProductInfoOptionErrorState {}
