part of 'product_grid_view_item_bloc.dart';

sealed class ProductGridViewItemEvent extends Equatable {
  const ProductGridViewItemEvent();

  @override
  List<Object> get props => [];
}

final class ProductGridViewItemShowExpandedEvent
    extends ProductGridViewItemEvent {}

final class ProductGridViewItemShowCollapsedEvent
    extends ProductGridViewItemEvent {}

final class ProductGridViewItemStartForwardAnimationEvent
    extends ProductGridViewItemEvent {}

final class ProductGridViewItemStartBackwardAnimationEvent
    extends ProductGridViewItemEvent {}
