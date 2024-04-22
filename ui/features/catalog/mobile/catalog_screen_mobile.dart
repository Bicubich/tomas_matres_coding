import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/ui/components/mobile/mobile_products_grid_view.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_chip_categories/cubit/tomas_category_chip_list_view_cubit.dart';
import 'package:tomas_matres/ui/components/tomas_error_text.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/catalog/components/catalog_pagination_widget.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_cubit.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_state.dart';
import 'package:tomas_matres/ui/features/catalog/mobile/components/catalog_screen_categories_chips_list_view.dart';
import 'package:tomas_matres/ui/features/catalog/mobile/components/catalog_screen_filter_and_sort_row.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/recommended_today/mobile/recommended_today_mobile.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';

class CatalogScreenMobile extends StatefulWidget {
  final String routePath;
  const CatalogScreenMobile({required this.routePath, super.key});

  @override
  State<CatalogScreenMobile> createState() => _CatalogScreenMobileState();
}

class _CatalogScreenMobileState extends State<CatalogScreenMobile> {
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16);

  int countOfProductsPerPage = 15;

  final NumberPaginatorController paginatorController =
      NumberPaginatorController();

  final GlobalKey productListColumnGlobalKey = GlobalKey();

  @override
  void dispose() {
    paginatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 485 &&
        MediaQuery.of(context).size.width < 785) {
      countOfProductsPerPage = 16;
    } else {
      countOfProductsPerPage = 15;
    }

    return BlocConsumer<CatalogCubit, CatalogState>(
      listener: (context, state) => state is CatalogErrorNotFound
          ? NavigationHelper.replaceRoute(context, Routes.notFound)
          : {},
      builder: (context, state) {
        if (state is CatalogLoaded) {
          int pageCount =
              (state.filteredProducts.length / countOfProductsPerPage).ceil();
          if (paginatorController.currentPage != state.activePage - 1) {
            paginatorController.currentPage = state.activePage - 1;
          }

          return BlocProvider(
            create: (context) => TomasCategoryChipListViewCubit(),
            child: MobileTemplate(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: padding,
                  child: Text(
                    state.parentCategory.name,
                    style: UiConstants.kTextStyleHeadline5.copyWith(
                        color: UiConstants.kColorText01,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                CatalogScreenCategoriesChipsButtonsListView(
                  parentCategory: state.parentCategory,
                  activeCategoryId: state.activeCategoryId,
                ),
                SizedBox(
                  key: productListColumnGlobalKey,
                  height: 40,
                ),
                Padding(
                  padding: padding,
                  child: CatalogScreenFilterAndSortRow(
                    sortedByIndex: state.sortedByIndex,
                    selectedCategoryProducts: state.selectedCategoryProducts,
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Padding(
                  padding: padding,
                  child: MobileProductsGridView(
                    products: getProductsPerPage(
                        state.filteredProducts, state.activePage),
                  ),
                ),
                const SizedBox(
                  height: 56,
                ),
                Visibility(
                  visible: pageCount > 1,
                  maintainState: true,
                  child: CatalogPaginationWidget(
                    activePage: state.activePage,
                    controller: paginatorController,
                    pageCount: pageCount <= 0 ? 1 : pageCount,
                    productListColumnGlobalKey: productListColumnGlobalKey,
                    countOfMaxVisibleNumbers:
                        MediaQuery.of(context).size.width < 485 ? 2 : 4,
                    onPageSelected: (index) => context
                        .read<CatalogCubit>()
                        .onPageSelected(index: index),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                const RecommendedTodayMobile(),
                const SizedBox(
                  height: 80,
                ),
                const FooterMobile(),
              ],
            ),
          );
        }

        if (state is CatalogLoading) {
          return const TomasLoadIndicator();
        }

        return const TomasErrorText();
      },
    );
  }

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
}
