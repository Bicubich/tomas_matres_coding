import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/data_models/categories/category_model.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_chip_categories/tomas_category_chip.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_cubit.dart';

class CategoryButtonsView extends StatelessWidget {
  final Category parentCategory;
  final String activeCategoryId;

  const CategoryButtonsView(
      {required this.parentCategory, required this.activeCategoryId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24.0,
      runSpacing: 24,
      children: List.generate(
        parentCategory.children.length + 1,
        (index) => TomasCategoryChip(
          title: index == 0
              ? LocaleKeys.kTextAll.tr()
              : parentCategory.children[index - 1].name,
          onTap: () {
            String categoryId = index == 0
                ? parentCategory.categoryId
                : parentCategory.children[index - 1].categoryId;
            context.read<CatalogCubit>().onCategoryTap(categoryId: categoryId);
          },
          isActive: index == 0
              ? parentCategory.categoryId == activeCategoryId
              : parentCategory.children[index - 1].categoryId ==
                  activeCategoryId,
          backgroundColor: UiConstants.kColorBase02,
          activeBackgroundColor: UiConstants.kColorLink,
          inActiveTextColor: UiConstants.kColorText03,
          activeTextColor: UiConstants.kColorText04,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 13),
        ),
      ),
    );
  }
}
