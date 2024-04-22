import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';

class DeliveryInfoTable extends StatefulWidget {
  const DeliveryInfoTable({super.key});

  @override
  State<DeliveryInfoTable> createState() => _DeliveryInfoTableState();
}

class _DeliveryInfoTableState extends State<DeliveryInfoTable> {
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
      6,
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
    LocaleKeys.kTextDeliveryInfoColumnTitle1.tr(),
    LocaleKeys.kTextDeliveryInfoColumnTitle2.tr(),
    LocaleKeys.kTextDeliveryInfoColumnTitle3.tr(),
    LocaleKeys.kTextDeliveryInfoColumnTitle4.tr(),
    LocaleKeys.kTextDeliveryInfoColumnTitle5.tr(),
    LocaleKeys.kTextDeliveryInfoColumnTitle6.tr(),
  ];

  List<String> secondRowTexts = [
    LocaleKeys.kTextDeliveryInfoRow2Column1Content.tr(),
    LocaleKeys.kTextDeliveryInfoRow2Column2Content.tr(),
    LocaleKeys.kTextDeliveryInfoRow2Column3Content.tr(),
    LocaleKeys.kTextDeliveryInfoRow2Column4Content.tr(),
    LocaleKeys.kTextDeliveryInfoRow2Column5Content.tr(),
    LocaleKeys.kTextDeliveryInfoRow2Column6Content.tr(),
  ];
}
