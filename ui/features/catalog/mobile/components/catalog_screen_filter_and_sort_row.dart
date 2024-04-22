import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_icon_with_text_button.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/catalog_cubit.dart';
import 'package:tomas_matres/ui/features/catalog/mobile/components/catalog_screen_filters_mobile.dart';
import 'package:tomas_matres/ui/features/catalog/mobile/components/catalog_screen_sort_drop_down.dart';

class CatalogScreenFilterAndSortRow extends StatelessWidget {
  final int sortedByIndex;
  final List<Product> selectedCategoryProducts;

  const CatalogScreenFilterAndSortRow(
      {required this.sortedByIndex,
      required this.selectedCategoryProducts,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TomasIconWithTextButton(
          onPressed: () => onFilterTap(context),
          iconPath: Paths.filterIconPath,
          text: LocaleKeys.kTextAllFilters.tr(),
          textColor: UiConstants.kColorLink,
          iconColor: UiConstants.kColorLink,
          textStyle: UiConstants.kTextStyleText5,
        ),
        CatalogScreenSortDropDown(
          selectedIndex: sortedByIndex,
          onChanged: (newValue) =>
              context.read<CatalogCubit>().onSortedByTap(index: newValue ?? 0),
        ),
      ],
    );
  }

  void onFilterTap(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (newContext) => BlocProvider<CatalogCubit>.value(
              value: BlocProvider.of<CatalogCubit>(context),
              child: CatalogScreenFiltersMobile(
                  selectedCategoryProducts: selectedCategoryProducts),
            ));
  }
}
