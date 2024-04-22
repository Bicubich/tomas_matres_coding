import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/mobile/mobile_products_grid_view.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/catalog/components/catalog_pagination_widget.dart';
import 'package:tomas_matres/ui/features/catalog/mobile/components/catalog_screen_sort_drop_down.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/common/header/search/cubit/top_menu_search_cubit.dart';
import 'package:tomas_matres/ui/features/main_screen/cubit/main_screen_cubit.dart';
import 'package:tomas_matres/ui/features/popular_categories/mobile/popular_categories_mobile.dart';
import 'package:tomas_matres/ui/features/recommended_today/mobile/recommended_today_mobile.dart';
import 'package:tomas_matres/ui/features/search_screen/components/category_buttons_view.dart';
import 'package:tomas_matres/ui/features/search_screen/cubit/search_screen_cubit.dart';
import 'package:tomas_matres/ui/features/search_screen/cubit/search_screen_state.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';

class SearchScreenMobile extends StatefulWidget {
  const SearchScreenMobile({super.key, this.searchInput});

  final String? searchInput;

  @override
  State<SearchScreenMobile> createState() => _SearchScreenMobileState();
}

class _SearchScreenMobileState extends State<SearchScreenMobile> {
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

    return MobileTemplate(
      children: [
        BlocProvider(
          create: (context) => SearchScreenCubit(
            notFoundSearchText: widget.searchInput,
            topMenuSearchCubit: BlocProvider.of<TopMenuSearchCubit>(context),
          ),
          child: BlocBuilder<SearchScreenCubit, SearchScreenState>(
            builder: (context, state) {
              if (state is SearchScreenLoaded) {
                int pageCount =
                    (state.resultsProducts.length / countOfProductsPerPage)
                        .ceil();
                if (paginatorController.currentPage != state.activePage - 1) {
                  paginatorController.currentPage = state.activePage - 1;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: padding,
                      child: RichText(
                        text: TextSpan(
                          text: LocaleKeys.kTextSearchResultsForYourQuery.tr(),
                          style: UiConstants.kTextStyleHeadline4
                              .copyWith(color: UiConstants.kColorText01),
                          children: [
                            TextSpan(
                              text: isUrlEncoded(widget.searchInput ?? '')
                                  ? Uri.decodeComponent(
                                      widget.searchInput ?? '')
                                  : widget.searchInput,
                              style: UiConstants.kTextStyleText1
                                  .copyWith(color: UiConstants.kColorText03),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 58,
                    ),
                    if (state.resultsCategories.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: padding,
                            child: Text(
                              LocaleKeys.kTextFoundInCategories.tr(),
                              style: UiConstants.kTextStyleHeadline3.copyWith(
                                  color: UiConstants.kColorText01, height: 1.5),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: padding,
                            child: CategoryButtonsView(
                              categories: (state).resultsCategories,
                              spacing: 8,
                              runSpacing: 8,
                              contentPadding: const EdgeInsets.all(16),
                              textStyle: UiConstants.kTextStyleText4,
                              chipRadius: 48,
                              isFirstAll: false,
                            ),
                          ),
                          SizedBox(
                            key: productListColumnGlobalKey,
                            height: 40,
                          ),
                          Padding(
                            padding: padding,
                            child: CatalogScreenSortDropDown(
                              selectedIndex: state.sortedByIndex,
                              onChanged: (newValue) => context
                                  .read<SearchScreenCubit>()
                                  .onSortedByTap(index: newValue ?? 0),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: padding,
                            child: MobileProductsGridView(
                              products: getProductsPerPage(
                                  state.resultsProducts, state.activePage),
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
                              productListColumnGlobalKey:
                                  productListColumnGlobalKey,
                              countOfMaxVisibleNumbers:
                                  MediaQuery.of(context).size.width < 485
                                      ? 2
                                      : 4,
                              onPageSelected: (index) =>
                                  BlocProvider.of<SearchScreenCubit>(context)
                                      .onPageSelected(index: index),
                            ),
                          ),
                        ],
                      ),
                    if (state.results.isEmpty)
                      Column(
                        children: [
                          Padding(
                            padding: padding,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                LocaleKeys.kTextNothingFound.tr(),
                                style: UiConstants.kTextStyleHeadline3.copyWith(
                                    color: UiConstants.kColorText01,
                                    height: 1.5),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          BlocBuilder<MainScreenCubit, MainScreenState>(
                            builder: (context, mainScreenState) {
                              if (mainScreenState is MainScreenLoaded) {
                                return PopularCategoriesMobile(
                                  popularCategories:
                                      BlocProvider.of<MainScreenCubit>(context)
                                          .popularCategories,
                                );
                              } else {
                                return const SizedBox(
                                  height: 400,
                                  child: TomasLoadIndicator(),
                                );
                              }
                            },
                          ),
                        ],
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
                );
              }
              return const SizedBox(height: 400, child: TomasLoadIndicator());
            },
          ),
        ),
      ],
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

  bool isUrlEncoded(String input) {
    // Проверяем наличие символов '%', за которыми следуют два шестнадцатеричных символа.
    return RegExp(r'%[0-9a-fA-F]{2}').hasMatch(input);
  }
}
