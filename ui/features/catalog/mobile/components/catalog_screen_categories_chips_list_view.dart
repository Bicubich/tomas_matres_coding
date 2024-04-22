import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/data_models/categories/category_model.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_chip_categories/tomas_category_chip.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_cubit.dart';

class CatalogScreenCategoriesChipsButtonsListView extends StatefulWidget {
  final Category parentCategory;
  final String activeCategoryId;

  const CatalogScreenCategoriesChipsButtonsListView(
      {required this.parentCategory, required this.activeCategoryId, Key? key})
      : super(key: key);

  @override
  State<CatalogScreenCategoriesChipsButtonsListView> createState() =>
      _CatalogScreenCategoriesChipsButtonsListViewState();
}

class _CatalogScreenCategoriesChipsButtonsListViewState
    extends State<CatalogScreenCategoriesChipsButtonsListView> {
  final ItemScrollController scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ScrollablePositionedList.builder(
              itemScrollController: scrollController,
              shrinkWrap: true,
              itemCount: widget.parentCategory.children.length + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      right: index == widget.parentCategory.children.length
                          ? 16
                          : 8),
                  child: TomasCategoryChip(
                    title: index == 0
                        ? LocaleKeys.kTextAll.tr()
                        : widget.parentCategory.children[index - 1].name,
                    onTap: () {
                      String categoryId = index == 0
                          ? widget.parentCategory.categoryId
                          : widget
                              .parentCategory.children[index - 1].categoryId;
                      context
                          .read<CatalogCubit>()
                          .onCategoryTap(categoryId: categoryId);

                      scrollController.jumpTo(index: index);
                    },
                    isActive: index == 0
                        ? widget.parentCategory.categoryId ==
                            widget.activeCategoryId
                        : widget.parentCategory.children[index - 1]
                                .categoryId ==
                            widget.activeCategoryId,
                    backgroundColor: UiConstants.kColorBase02,
                    activeBackgroundColor: UiConstants.kColorLink,
                    inActiveTextColor: UiConstants.kColorText03,
                    activeTextColor: UiConstants.kColorText04,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: UiConstants.kTextStyleText6,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
