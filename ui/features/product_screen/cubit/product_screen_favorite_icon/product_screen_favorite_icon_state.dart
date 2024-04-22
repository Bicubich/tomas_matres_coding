part of 'product_screen_favorite_icon_cubit.dart';

sealed class ProductScreenFavoriteIconState extends Equatable {
  const ProductScreenFavoriteIconState();

  @override
  List<Object> get props => [];
}

final class ProductScreenFavoriteIconInactive
    extends ProductScreenFavoriteIconState {}

final class ProductScreenFavoriteIconActive
    extends ProductScreenFavoriteIconState {}
