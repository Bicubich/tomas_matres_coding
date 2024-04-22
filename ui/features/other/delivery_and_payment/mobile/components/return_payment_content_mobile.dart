import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/data/delivery_and_payment_data.dart';

class ReturnPaymentContentMobile extends StatelessWidget {
  const ReturnPaymentContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.kTextReturnPayment.tr(),
            style: UiConstants.kTextStyleHeadline4.copyWith(
              color: UiConstants.kColorText01,
            )),
        const SizedBox(
          height: 32,
        ),
        Text(
          DeliveryAndPaymentData.returnPaymentContent,
          style: UiConstants.kTextStyleText3.copyWith(
            color: UiConstants.kColorText02,
            height: 1.75,
          ),
        ),
      ],
    );
  }
}
