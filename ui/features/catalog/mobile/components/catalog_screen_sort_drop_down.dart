import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';

class CatalogScreenSortDropDown extends StatefulWidget {
  final int selectedIndex;
  final Function(int? newValue) onChanged;

  const CatalogScreenSortDropDown(
      {required this.selectedIndex, super.key, required this.onChanged});

  @override
  CatalogScreenSortDropDownState createState() =>
      CatalogScreenSortDropDownState();
}

class CatalogScreenSortDropDownState extends State<CatalogScreenSortDropDown> {
  final List<String> productSortTitleList = [
    LocaleKeys.kTextByPopularity.tr(),
    LocaleKeys.kTextCheaperFirst.tr(),
    LocaleKeys.kTextExpensiveFirst.tr(),
    LocaleKeys.kTextWithDiscount.tr()
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: DropdownButton<int>(
        style: UiConstants.kTextStyleText5
            .copyWith(color: UiConstants.kColorText02),
        underline: Container(),
        borderRadius: BorderRadius.circular(24),
        focusColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        value: widget.selectedIndex,
        onChanged: widget.onChanged,
        items: List.generate(
          productSortTitleList.length,
          (index) => DropdownMenuItem<int>(
            value: index,
            child: Text(productSortTitleList[index]),
          ),
        ),
      ),
    );
  }
}
