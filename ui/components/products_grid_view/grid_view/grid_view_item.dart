import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/ui/components/products_grid_view/bloc/product_grid_view_item_bloc.dart';
import 'package:tomas_matres/ui/components/products_grid_view/card/products_list_card.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/functions/products_grid_view_functions.dart';

class GridViewItem extends StatelessWidget {
  final int index;
  final Product product;
  final int countOfElementsPerRow;
  final int maxCountOfElementsPerRow;

  const GridViewItem(
      {required this.index,
      required this.product,
      required this.countOfElementsPerRow,
      required this.maxCountOfElementsPerRow,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ProductsGridViewFunctions.getTopPosition(
          index: index, countOfElementsPerRow: countOfElementsPerRow),
      left: ProductsGridViewFunctions.getLeftPosition(
        context: context,
        index: index,
        countOfElementsPerRow: countOfElementsPerRow,
        maxCountOfElementsPerRow: maxCountOfElementsPerRow,
      ),
      right: ProductsGridViewFunctions.getRightPosition(
        context: context,
        index: index,
        countOfElementsPerRow: countOfElementsPerRow,
        maxCountOfElementsPerRow: maxCountOfElementsPerRow,
      ),
      child: SizedBox(
        height: 408,
        width: ProductsGridViewFunctions.reSize(
            context: context,
            maxCountOfElementsPerRow: maxCountOfElementsPerRow),
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (event) => onHover(context),
            child: GestureDetector(
              onTap: () => NavigationHelper.openInNewTab(
                  '${Routes.productScreen.path}&id=${product.id}'),
              child: ProductsListCard(
                product: product,
              ),
            )),
      ),
    );
  }

  void onHover(BuildContext context) {
    BlocProvider.of<ProductGridViewItemBloc>(context)
        .add(ProductGridViewItemShowExpandedEvent());
  }
}
