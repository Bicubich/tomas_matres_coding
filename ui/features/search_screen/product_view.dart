import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/products_grid_view.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/catalog/products/product_sort_item.dart';
import 'package:tomas_matres/ui/features/search_screen/components/search_screen_pagination_widget.dart';
import 'package:tomas_matres/ui/features/search_screen/cubit/search_screen_cubit.dart';
import 'package:tomas_matres/ui/features/search_screen/cubit/search_screen_state.dart';

class ProductView extends StatelessWidget {
  final NumberPaginatorController paginatorController;
  final GlobalKey productViewGlobalKey;
  ProductView({
    super.key,
    required this.paginatorController,
    required this.products,
    required this.productViewGlobalKey,
  });

  final List<Product> products;

  final int countOfProductsPerPage = 20;

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
    return BlocBuilder<SearchScreenCubit, SearchScreenState>(
      builder: (context, searchScreenState) {
        if (searchScreenState is SearchScreenLoaded) {
          int pageCount = (searchScreenState.resultsProducts.length /
                  countOfProductsPerPage)
              .ceil();
          if (paginatorController.currentPage !=
              searchScreenState.activePage - 1) {
            paginatorController.currentPage = searchScreenState.activePage - 1;
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
                          .read<SearchScreenCubit>()
                          .onSortedByTap(index: index),
                      isSelected: (searchScreenState).sortedByIndex == index,
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
                        searchScreenState.resultsProducts,
                        searchScreenState.activePage),
                  ),
                  Visibility(
                    visible: pageCount > 1,
                    maintainState: true,
                    child: SearchScreenPaginationWidget(
                      activePage: searchScreenState.activePage,
                      controller: paginatorController,
                      pageCount: pageCount,
                      productViewGlobalKey: productViewGlobalKey,
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
