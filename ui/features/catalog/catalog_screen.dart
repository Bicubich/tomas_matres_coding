import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_chip_categories/cubit/tomas_category_chip_list_view_cubit.dart';
import 'package:tomas_matres/ui/components/tomas_error_text.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/catalog/components/category_buttons_view.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_cubit.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_state.dart';
import 'package:tomas_matres/ui/features/catalog/filters/filter_column.dart';
import 'package:tomas_matres/ui/features/catalog/mobile/catalog_screen_mobile.dart';
import 'package:tomas_matres/ui/features/catalog/products/product_list_column.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/common/navigation/navigation_widget.dart';
import 'package:tomas_matres/ui/features/interior_ideas/interior_ideas.dart';
import 'package:tomas_matres/ui/features/recommended_today/recommended_today.dart';
import 'package:tomas_matres/ui/features/template/template.dart';

class CatalogScreen extends StatefulWidget {
  final String categoryId;
  final String? subCategoryId;
  final bool withSale;
  final String routePath;
  const CatalogScreen(
      {required this.categoryId,
      this.subCategoryId,
      this.withSale = false,
      required this.routePath,
      super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final ScrollController scrollController = ScrollController();
  final NumberPaginatorController paginatorController =
      NumberPaginatorController();

  final GlobalKey productListColumnGlobalKey = GlobalKey();

  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 40);

  @override
  void dispose() {
    scrollController.dispose();
    paginatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CatalogCubit(
            parentCategoryId: widget.categoryId,
            subcategoryId: widget.subCategoryId,
            withSale: widget.withSale,
          ),
        ),
        BlocProvider<TomasCategoryChipListViewCubit>(
          create: (context) => TomasCategoryChipListViewCubit(),
        ),
      ],
      child: MediaQuery.of(context).size.width < UiConstants.minDesktopWidth
          ? CatalogScreenMobile(
              routePath: widget.routePath,
            )
          : BlocConsumer<CatalogCubit, CatalogState>(
              listener: (context, state) => state is CatalogErrorNotFound
                  ? NavigationHelper.replaceRoute(context, Routes.notFound)
                  : {},
              builder: (context, state) {
                if (state is CatalogLoaded) {
                  return PageTemplate(
                    body: Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(
                            horizontal: Utils.calculatePadding(context)),
                        shrinkWrap: true,
                        children: [
                          NavigationWidget(
                            customRoute: CustomRoute(
                                title: state.parentCategory.name,
                                path: widget.routePath),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 51, bottom: 59, left: 40, right: 40),
                                child: Text(
                                  state.parentCategory.name,
                                  style:
                                      UiConstants.kTextStyleHeadline1.copyWith(
                                    color: UiConstants.kColorText01,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: padding,
                                child: CategoryButtonsView(
                                  parentCategory: state.parentCategory,
                                  activeCategoryId: state.activeCategoryId,
                                ),
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: padding.left),
                                    child: FilterColumn(
                                      products: state.selectedCategoryProducts,
                                    ),
                                  ),
                                  state.filteredProducts.isNotEmpty
                                      ? ProductListColumn(
                                          key: productListColumnGlobalKey,
                                          productListColumnGlobalKey:
                                              productListColumnGlobalKey,
                                          paginatorController:
                                              paginatorController,
                                          products: state.filteredProducts,
                                        )
                                      : Expanded(
                                          child: Container(
                                            height: 300,
                                            alignment: Alignment.center,
                                            child: Text(
                                              LocaleKeys.kTextNoProducts.tr(),
                                              style: UiConstants
                                                  .kTextStyleHeadline3
                                                  .copyWith(
                                                      color: UiConstants
                                                          .kColorText02),
                                            ),
                                          ),
                                        )
                                ],
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
                            ],
                          ),
                          Footer(
                            scrollController: scrollController,
                          )
                        ],
                      ),
                    ),
                  );
                }
                if (state is CatalogLoading) {
                  return const TomasLoadIndicator();
                }

                return const TomasErrorText();
              },
            ),
    );
  }
}
