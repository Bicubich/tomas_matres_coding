import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';

class ServiceAssemblyTable extends StatefulWidget {
  const ServiceAssemblyTable({super.key});

  @override
  State<ServiceAssemblyTable> createState() => _ServiceAssemblyTableState();
}

class _ServiceAssemblyTableState extends State<ServiceAssemblyTable> {
  final double firstRowHeight = 154;
  final double secondRowHeight = 158;
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 10);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: UiConstants.kColorBase03,
        borderRadius: BorderRadius.circular(24),
      ),
      children: [
        TableRow(children: generateTableRow(firstRowTexts, isFirstRow: true)),
        TableRow(children: generateTableRow(secondRowTexts))
      ],
    );
  }

  List<Widget> generateTableRow(List<String> itemsList,
      {bool isFirstRow = false}) {
    double height = secondRowHeight;
    Color textColor = UiConstants.kColorText02;
    if (isFirstRow) {
      height = firstRowHeight;
      textColor = UiConstants.kColorText03;
    }
    List<Widget> tableRow = List.generate(
      3,
      (index) => Container(
        alignment: Alignment.center,
        height: height,
        padding: padding,
        child: Text(
          itemsList[index],
          style: UiConstants.kTextStyleText1.copyWith(
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return tableRow;
  }

  List<String> firstRowTexts = [
    LocaleKeys.kTextAssemblyInfoColumnTitle1.tr(),
    LocaleKeys.kTextAssemblyInfoColumnTitle2.tr(),
    LocaleKeys.kTextAssemblyInfoColumnTitle3.tr(),
  ];

  List<String> secondRowTexts = [
    LocaleKeys.kTextAssemblyInfoRow2Column1Content.tr(),
    LocaleKeys.kTextAssemblyInfoRow2Column2Content.tr(),
    LocaleKeys.kTextAssemblyInfoRow2Column3Content.tr(),
  ];
}
