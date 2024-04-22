part of 'product_grid_view_item_bloc.dart';

sealed class ProductGridViewItemState extends Equatable {
  const ProductGridViewItemState();

  @override
  List<Object> get props => [];
}

final class ProductGridViewItemCollapsedState extends ProductGridViewItemState {
  final bool selected;

  const ProductGridViewItemCollapsedState({required this.selected});

  @override
  List<Object> get props => [selected];
}

final class ProductGridViewItemExpandedState extends ProductGridViewItemState {
  final bool selected;

  const ProductGridViewItemExpandedState({required this.selected});

  @override
  List<Object> get props => [selected];
}
