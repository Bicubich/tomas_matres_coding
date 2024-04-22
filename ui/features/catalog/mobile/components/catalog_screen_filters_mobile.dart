import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';
import 'package:tomas_matres/ui/features/catalog/mobile/components/catalog_screen_filter_list_mobile.dart';

class CatalogScreenFiltersMobile extends StatelessWidget {
  final List<Product> selectedCategoryProducts;

  const CatalogScreenFiltersMobile(
      {required this.selectedCategoryProducts, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 40,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.kTextFilter.tr(),
                  style: UiConstants.kTextStyleHeadline4
                      .copyWith(color: UiConstants.kColorText01),
                ),
                TomasIconButton(
                  onPressed: () => Navigator.pop(context),
                  iconPath: Paths.xIconPath,
                  width: 21,
                  height: 21,
                  iconColor: UiConstants.kColorBase05,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 44,
          ),
          FilterListMobile(products: selectedCategoryProducts)
        ],
      ),
    );
  }
}
