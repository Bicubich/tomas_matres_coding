import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/data_models/categories/category_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_text_button.dart';

class CategorySectionItem extends StatelessWidget {
  final Category category;
  final int index;
  final String title;
  final List<Product> products;
  final String activeCategoryId;
  final Function(String) onTap;

  const CategorySectionItem({
    Key? key,
    required this.category,
    required this.index,
    required this.title,
    required this.products,
    required this.onTap,
    required this.activeCategoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TomasTextButton(
                text: title,
                selected: index != 0
                    ? isSelected()
                    : category.categoryId == activeCategoryId,
                textStyle: UiConstants.kTextStyleText2,
                foregroundColor: UiConstants.kColorText03,
                onPressed: () => onTap(category.categoryId),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              getCountOfProductsInCategory(category),
              style: UiConstants.kTextStyleText2.copyWith(
                color: UiConstants.kColorText05,
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool isSelected() {
    if (category.categoryId == activeCategoryId) {
      return true;
    } else {
      for (Category childCategory in category.children) {
        if (childCategory.categoryId == activeCategoryId) {
          return true;
        }
      }

      return false;
    }
  }

  String getCountOfProductsInCategory(Category category) {
    int count = 0;
    for (Product product in products) {
      if (product.categoryIds.contains(category.categoryId)) {
        count += 1;
      }
    }
    return count.toString();
  }
}
