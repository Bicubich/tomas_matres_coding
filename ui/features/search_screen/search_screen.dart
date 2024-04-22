import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/common/header/search/cubit/top_menu_search_cubit.dart';
import 'package:tomas_matres/ui/features/interior_ideas/interior_ideas.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/common/navigation/navigation_widget.dart';
import 'package:tomas_matres/ui/features/main_screen/cubit/main_screen_cubit.dart';
import 'package:tomas_matres/ui/features/popular_categories/popular_categories.dart';
import 'package:tomas_matres/ui/features/recommended_today/recommended_today.dart';
import 'package:tomas_matres/ui/features/search_screen/components/category_buttons_view.dart';
import 'package:tomas_matres/ui/features/search_screen/mobile/search_screen_mobile.dart';
import 'package:tomas_matres/ui/features/search_screen/product_view.dart';
import 'package:tomas_matres/ui/features/search_screen/cubit/search_screen_cubit.dart';
import 'package:tomas_matres/ui/features/search_screen/cubit/search_screen_state.dart';
import 'package:tomas_matres/ui/features/template/template.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.searchInput});

  final String? searchInput;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController scrollController = ScrollController();
  final NumberPaginatorController paginatorController =
      NumberPaginatorController();

  final GlobalKey productViewGlobalKey = GlobalKey();

  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 40);

  @override
  void dispose() {
    scrollController.dispose();
    paginatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < UiConstants.minDesktopWidth) {
      return SearchScreenMobile(searchInput: widget.searchInput);
    }
    return PageTemplate(
      body: BlocProvider(
        create: (context) => SearchScreenCubit(
          notFoundSearchText: widget.searchInput,
          topMenuSearchCubit: BlocProvider.of<TopMenuSearchCubit>(context),
        ),
        child: BlocBuilder<SearchScreenCubit, SearchScreenState>(
          builder: (context, state) {
            if (state is SearchScreenLoaded) {
              return Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: Utils.calculatePadding(context),
                  ),
                  cacheExtent: 6000,
                  children: [
                    const NavigationWidget(),
                    Padding(
                      padding: padding,
                      child: RichText(
                        text: TextSpan(
                          text: LocaleKeys.kTextSearchResultsForYourQuery.tr(),
                          style: UiConstants.kTextStyleHeadline2.copyWith(
                              color: UiConstants.kColorText01, fontSize: 22),
                          children: [
                            TextSpan(
                              text: isUrlEncoded(widget.searchInput ?? '')
                                  ? Uri.decodeComponent(
                                      widget.searchInput ?? '')
                                  : widget.searchInput,
                              style: UiConstants.kTextStyleHeadline2.copyWith(
                                  color: UiConstants.kColorText03,
                                  fontSize: 22),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    if (state.resultsCategories.isNotEmpty)
                      Padding(
                        padding: padding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.kTextFoundInCategories.tr(),
                              style: UiConstants.kTextStyleHeadline2.copyWith(
                                color: UiConstants.kColorText01,
                              ),
                            ),
                            const SizedBox(
                              height: 56,
                            ),
                            CategoryButtonsView(
                              categories: (state).resultsCategories,
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    if (state.resultsProducts.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductView(
                            key: productViewGlobalKey,
                            paginatorController: paginatorController,
                            products: (state).resultsProducts,
                            productViewGlobalKey: productViewGlobalKey,
                          ),
                        ],
                      ),
                    if (state.results.isEmpty)
                      Padding(
                        padding: padding,
                        child: Text(
                          LocaleKeys.kTextNothingFound.tr(),
                          style: UiConstants.kTextStyleHeadline2
                              .copyWith(color: UiConstants.kColorText01),
                        ),
                      ),
                    if (state.results.isEmpty)
                      const SizedBox(
                        height: 200,
                      ),
                    if (state.results.isEmpty)
                      Padding(
                        padding: padding,
                        child: BlocBuilder<MainScreenCubit, MainScreenState>(
                          builder: (context, mainScreenState) {
                            if (mainScreenState is MainScreenLoaded) {
                              return PopularCategories(
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
                      ),
                    const SizedBox(
                      height: 120,
                    ),
                    const InteriorIdeas(),
                    const SizedBox(
                      height: 120,
                    ),
                    Padding(
                      padding: padding,
                      child: const RecommendedToday(),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Footer(
                      scrollController: scrollController,
                    )
                  ],
                ),
              );
            }
            return const SizedBox(height: 400, child: TomasLoadIndicator());
          },
        ),
      ),
    );
  }

  bool isUrlEncoded(String input) {
    // Проверяем наличие символов '%', за которыми следуют два шестнадцатеричных символа.
    return RegExp(r'%[0-9a-fA-F]{2}').hasMatch(input);
  }
}
