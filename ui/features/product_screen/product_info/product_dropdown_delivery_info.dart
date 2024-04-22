import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_text_button.dart';

class ProductDropdownDeliveryInfo extends StatelessWidget {
  const ProductDropdownDeliveryInfo({super.key, this.fontSize = 20});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo1.tr(),
            style: UiConstants.kTextStyleText1
                .copyWith(color: UiConstants.kColorText02, fontSize: fontSize),
            children: [
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo2.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText03, fontSize: fontSize),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo3.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText02, fontSize: fontSize),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo4.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText03, fontSize: fontSize),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo5.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText02, fontSize: fontSize),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo6.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText03, fontSize: fontSize),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo7.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText02, fontSize: fontSize),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo8.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText03, fontSize: fontSize),
              ),
            ],
          ),
        ),
        TomasTextButton(
          onPressed: () =>
              NavigationHelper.addRoute(context, Routes.deliveryAndPayment),
          text: LocaleKeys.kTextCartSummaryColumnDeliveryInfoMoreDetails.tr(),
          textStyle: UiConstants.kTextStyleText1.copyWith(fontSize: fontSize),
          foregroundColor: UiConstants.kColorLink,
        ),
      ],
    );
  }
}
