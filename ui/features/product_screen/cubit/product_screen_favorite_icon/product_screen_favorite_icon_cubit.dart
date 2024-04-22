import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/top_menu_favorite/top_menu_favorite_cubit.dart';

part 'product_screen_favorite_icon_state.dart';

class ProductScreenFavoriteIconCubit
    extends Cubit<ProductScreenFavoriteIconState> {
  final TopMenuFavoriteCubit topMenuFavoriteCubit;
  final String productId;
  ProductScreenFavoriteIconCubit(
      {required this.topMenuFavoriteCubit, required this.productId})
      : super(ProductScreenFavoriteIconInactive()) {
    _init();
  }

  Future<void> _init() async {
    update();

    topMenuFavoriteCubit.updatesStreamController.stream.listen((event) {
      if (event) {
        update();
      }
    });
  }

  void update() {
    if (topMenuFavoriteCubit.isInCart(productId)) {
      emit(ProductScreenFavoriteIconActive());
    } else {
      emit(ProductScreenFavoriteIconInactive());
    }
  }
}
