import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/products_grid_view.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/catalog/components/catalog_pagination_widget.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_cubit.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_state.dart';
import 'package:tomas_matres/ui/features/catalog/products/product_sort_item.dart';

class ProductListColumn extends StatelessWidget {
  final GlobalKey productListColumnGlobalKey;
  final NumberPaginatorController paginatorController;
  final List<Product> products;

  ProductListColumn(
      {super.key,
      required this.productListColumnGlobalKey,
      required this.paginatorController,
      required this.products});

  final int countOfProductsPerPage = 15;

  final List<String> productSortTitleList = [
    LocaleKeys.kTextByPopularity.tr(),
    LocaleKeys.kTextCheaperFirst.tr(),
    LocaleKeys.kTextExpensiveFirst.tr(),
    LocaleKeys.kTextWithDiscount.tr()
  ];

  List<Product> getProductsPerPage(List<Product> products, int activePage) {
    final int start =
        activePage == 1 ? 0 : (countOfProductsPerPage * (activePage - 1));
    int? end;

    if ((products.length - start) > countOfProductsPerPage) {
      end = (countOfProductsPerPage * activePage);
    }

    List<Product> result = products.sublist(start, end);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, catalogState) {
        if (catalogState is CatalogLoaded) {
          int pageCount =
              (catalogState.filteredProducts.length / countOfProductsPerPage)
                  .ceil();
          if (paginatorController.currentPage != catalogState.activePage - 1) {
            paginatorController.currentPage = catalogState.activePage - 1;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Wrap(
                  spacing: 56,
                  runSpacing: 28,
                  children: List.generate(
                    productSortTitleList.length,
                    (index) => ProductSortItem(
                      index: index,
                      onTap: (index) => context
                          .read<CatalogCubit>()
                          .onSortedByTap(index: index),
                      isSelected: (catalogState).sortedByIndex == index,
                      text: productSortTitleList[index],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProductsGridView(
                    products: getProductsPerPage(
                        catalogState.filteredProducts, catalogState.activePage),
                    maxCountOfElementsPerRow: 3,
                  ),
                  Visibility(
                    visible: pageCount > 1,
                    maintainState: true,
                    child: CatalogPaginationWidget(
                      activePage: catalogState.activePage,
                      controller: paginatorController,
                      pageCount: pageCount,
                      productListColumnGlobalKey: productListColumnGlobalKey,
                      onPageSelected: (index) =>
                          BlocProvider.of<CatalogCubit>(context)
                              .onPageSelected(index: index),
                    ),
                  )
                ],
              ),
            ],
          );
        }
        return const TomasLoadIndicator();
      },
    );
  }
}
