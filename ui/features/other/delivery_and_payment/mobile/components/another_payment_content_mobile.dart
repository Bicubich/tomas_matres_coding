import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/other/contacts/mobile/components/payment_details_mobile.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/data/delivery_and_payment_data.dart';

class AnotherPaymentContentMobile extends StatelessWidget {
  const AnotherPaymentContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.kTextAnotherPaymentOption.tr(),
            style: UiConstants.kTextStyleHeadline4.copyWith(
              color: UiConstants.kColorText01,
            )),
        const SizedBox(
          height: 32,
        ),
        Text(
          DeliveryAndPaymentData.anotherPaymentContent1,
          style: UiConstants.kTextStyleText3.copyWith(
            color: UiConstants.kColorText02,
            height: 1.75,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 110,
              width: 8,
              color: UiConstants.kColorPrimary,
            ),
            const SizedBox(
              width: 17,
            ),
            Expanded(
              child: Text(
                DeliveryAndPaymentData.anotherPaymentContent2,
                style: UiConstants.kTextStyleText3.copyWith(
                  color: UiConstants.kColorText02,
                  height: 1.75,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Text(DeliveryAndPaymentData.anotherPaymentContent3,
            style: UiConstants.kTextStyleText3.copyWith(
                color: UiConstants.kColorText02,
                height: 1.75,
                fontWeight: FontWeight.w700)),
        const SizedBox(
          height: 24,
        ),
        const PaymentDetailsMobile()
      ],
    );
  }
}
