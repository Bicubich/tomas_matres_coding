import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_text_button.dart';

class SummaryColumnInfoDropdownPayment extends StatelessWidget {
  const SummaryColumnInfoDropdownPayment(
      {super.key, this.textStyleBody = UiConstants.kTextStyleText1});

  final TextStyle textStyleBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.kTextCartSummaryColumnPaymentInfo.tr(),
          style: textStyleBody.copyWith(color: UiConstants.kColorText02),
        ),
        TomasTextButton(
          onPressed: () =>
              NavigationHelper.addRoute(context, Routes.deliveryAndPayment),
          text: LocaleKeys.kTextCartSummaryColumnPaymentInfoMoreDetails.tr(),
          textStyle: textStyleBody,
          foregroundColor: UiConstants.kColorLink,
        ),
      ],
    );
  }
}
