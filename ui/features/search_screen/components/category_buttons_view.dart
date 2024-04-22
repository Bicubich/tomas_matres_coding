import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/data_models/categories/category_model.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_chip_categories/tomas_category_chip.dart';

class CategoryButtonsView extends StatelessWidget {
  final List<Category> categories;
  final EdgeInsets contentPadding;
  final double spacing;
  final double runSpacing;
  final TextStyle textStyle;
  final double chipRadius;
  final bool isFirstAll;

  const CategoryButtonsView({
    Key? key,
    required this.categories,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
    this.spacing = 24,
    this.runSpacing = 24,
    this.textStyle = UiConstants.kTextStyleHeadline3,
    this.chipRadius = 32,
    this.isFirstAll = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: List.generate(
        categories.length,
        (index) => TomasCategoryChip(
          title: isFirstAll
              ? index == 0
                  ? LocaleKeys.kTextAll.tr()
                  : categories[index].name
              : categories[index].name,
          onTap: () {
            onCategoryTap(
                context, categories[index].categoryId, categories[index].name);
          },
          isActive: false,
          backgroundColor: UiConstants.kColorBase02,
          activeBackgroundColor: UiConstants.kColorLink,
          inActiveTextColor: UiConstants.kColorText03,
          activeTextColor: UiConstants.kColorText04,
          padding: contentPadding,
          textStyle: textStyle,
        ),
      ),
    );
  }

  void onCategoryTap(
      BuildContext context, String categoryId, String categoryName) {
    List<CustomRoute> routes = [
      Routes.catalog,
      CustomRoute(
          title: categoryName,
          path: '${Routes.catalog.path}&category_id=$categoryId')
    ];
    NavigationHelper.addMultipleRoutes(context, routes);
  }
}
