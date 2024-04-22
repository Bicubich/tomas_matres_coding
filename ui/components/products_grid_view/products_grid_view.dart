import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/ui/components/products_grid_view/bloc/product_grid_view_item_bloc.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/functions/products_grid_view_functions.dart';
import 'package:tomas_matres/ui/components/products_grid_view/grid_view/grid_view_item.dart';
import 'package:tomas_matres/ui/components/products_grid_view/grid_view/grid_view_item_expanded.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/favorite_icon/favorite_icon_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/top_menu_favorite/top_menu_favorite_cubit.dart';

class ProductsGridView extends StatefulWidget {
  final List<Product> products;
  final int maxCountOfElementsPerRow;

  const ProductsGridView(
      {required this.products, this.maxCountOfElementsPerRow = 4, super.key});

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  List<ProductGridViewItemBloc> productGridViewItemBlocInstances = [];
  List<FavoriteIconCubit> favoriteIconCubitInstances = [];

  int countOfElementsPerRow = 0;
  int countOfRows = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.products.length < 4) {
      countOfElementsPerRow = widget.products.length;
      countOfRows = 1;
    } else {
      countOfElementsPerRow = widget.maxCountOfElementsPerRow;
      countOfRows = (widget.products.length / countOfElementsPerRow).ceil();
    }
    return Container(
      constraints: BoxConstraints(
          maxHeight:
              countOfRows == 1 ? 610 : (485 * (countOfRows)).toDouble() + 110,
          maxWidth: ProductsGridViewFunctions.getAvailableSpace(
              context, widget.maxCountOfElementsPerRow)),
      child: Stack(
        children: generateItems(),
      ),
    );
  }

  @override
  void dispose() {
    for (ProductGridViewItemBloc bloc in productGridViewItemBlocInstances) {
      bloc.close();
    }
    super.dispose();
  }

  List<Widget> generateItems() {
    final int countOfElements = widget.products.length;

    List<Widget> result = List.generate(countOfElements * 2, (index) {
      late ProductGridViewItemBloc currentProductGridViewItemBlocInstance;
      late FavoriteIconCubit currentFavoriteIconCubitInstance;

      // Нижние, маленькие карточки
      if (index <= countOfElements - 1) {
        // Инициализируем bloc и сохраняем его для использования в расширенной карточке
        currentProductGridViewItemBlocInstance = ProductGridViewItemBloc();
        productGridViewItemBlocInstances
            .add(currentProductGridViewItemBlocInstance);

        // Инициализируем cubit и сохраняем его для использования в расширенной карточке
        currentFavoriteIconCubitInstance = FavoriteIconCubit(
            topMenuFavoriteCubit:
                BlocProvider.of<TopMenuFavoriteCubit>(context),
            productId: widget.products[index].id);
        favoriteIconCubitInstances.add(currentFavoriteIconCubitInstance);

        Product product = widget.products[index];

        return BlocProvider<ProductGridViewItemBloc>.value(
          value: currentProductGridViewItemBlocInstance,
          child: BlocProvider<FavoriteIconCubit>.value(
            value: currentFavoriteIconCubitInstance,
            child: GridViewItem(
              index: index,
              product: product,
              countOfElementsPerRow: countOfElementsPerRow,
              maxCountOfElementsPerRow: widget.maxCountOfElementsPerRow,
            ),
          ),
        );
      } else {
        // Верхние расширенные карточки
        // Изменяем индекс на соответствие нижним элементам
        final int modifiedIndex = index - countOfElements;

        // Получаем bloc используемый в маленькой карточке
        currentProductGridViewItemBlocInstance =
            productGridViewItemBlocInstances[modifiedIndex];
        // Получаем cubit используемый в маленькой карточке
        currentFavoriteIconCubitInstance =
            favoriteIconCubitInstances[modifiedIndex];

        Product product = widget.products[modifiedIndex];

        return BlocProvider<ProductGridViewItemBloc>.value(
          value: currentProductGridViewItemBlocInstance,
          child: BlocProvider<FavoriteIconCubit>.value(
            value: currentFavoriteIconCubitInstance,
            child: GridViewItemExpanded(
              index: modifiedIndex,
              product: product,
              countOfElementsPerRow: countOfElementsPerRow,
              maxCountOfElementsPerRow: widget.maxCountOfElementsPerRow,
            ),
          ),
        );
      }
    });

    return result;
  }
}
