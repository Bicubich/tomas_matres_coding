part of 'product_info_option_hover_cubit.dart';

class ProductInfoOptionHoverState extends Equatable {
  final String? hoveredOptionId;

  const ProductInfoOptionHoverState({this.hoveredOptionId});

  @override
  List<Object?> get props => [hoveredOptionId];
}
