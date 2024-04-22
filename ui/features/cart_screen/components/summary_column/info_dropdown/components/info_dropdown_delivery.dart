import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_text_button.dart';

class SummaryColumnInfoDropdownDelivery extends StatelessWidget {
  const SummaryColumnInfoDropdownDelivery(
      {super.key, this.textStyleBody = UiConstants.kTextStyleText1});

  final TextStyle textStyleBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo1.tr(),
            style: textStyleBody.copyWith(color: UiConstants.kColorText02),
            children: [
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo2.tr(),
                style: textStyleBody.copyWith(color: UiConstants.kColorText03),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo3.tr(),
                style: textStyleBody.copyWith(color: UiConstants.kColorText02),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo4.tr(),
                style: textStyleBody.copyWith(color: UiConstants.kColorText03),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo5.tr(),
                style: textStyleBody.copyWith(color: UiConstants.kColorText02),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo6.tr(),
                style: textStyleBody.copyWith(color: UiConstants.kColorText03),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo7.tr(),
                style: textStyleBody.copyWith(color: UiConstants.kColorText02),
              ),
              TextSpan(
                text: LocaleKeys.kTextCartSummaryColumnDeliveryInfo8.tr(),
                style: textStyleBody.copyWith(color: UiConstants.kColorText03),
              ),
            ],
          ),
        ),
        TomasTextButton(
          onPressed: () =>
              NavigationHelper.addRoute(context, Routes.deliveryAndPayment),
          text: LocaleKeys.kTextCartSummaryColumnDeliveryInfoMoreDetails.tr(),
          textStyle: textStyleBody,
          foregroundColor: UiConstants.kColorLink,
        ),
      ],
    );
  }
}
