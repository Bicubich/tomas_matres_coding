import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/common/footer/data/footer_data.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/data/delivery_and_payment_data.dart';

class PaymentContentMobile extends StatelessWidget {
  const PaymentContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.kTextPayment.tr(),
            style: UiConstants.kTextStyleHeadline4.copyWith(
              color: UiConstants.kColorText01,
            )),
        const SizedBox(
          height: 32,
        ),
        Text(
          DeliveryAndPaymentData.paymentContent1,
          style: UiConstants.kTextStyleText3.copyWith(
            color: UiConstants.kColorText02,
            height: 1.75,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          DeliveryAndPaymentData.paymentContent2,
          softWrap: true,
          style: UiConstants.kTextStyleText3.copyWith(
            color: UiConstants.kColorText02,
            height: 1.75,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 14,
              height: 2,
              margin: const EdgeInsets.only(top: 15),
              color: UiConstants.kColorPrimary,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                DeliveryAndPaymentData.paymentContent3,
                style: UiConstants.kTextStyleText3.copyWith(
                  color: UiConstants.kColorText02,
                  height: 1.75,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 14,
              height: 2,
              margin: const EdgeInsets.only(top: 15),
              color: UiConstants.kColorPrimary,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                DeliveryAndPaymentData.paymentContent4,
                style: UiConstants.kTextStyleText3.copyWith(
                  color: UiConstants.kColorText02,
                  height: 1.75,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 14,
              height: 2,
              margin: const EdgeInsets.only(top: 15),
              color: UiConstants.kColorPrimary,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                DeliveryAndPaymentData.paymentContent5,
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
        RichText(
          text: TextSpan(
            text: DeliveryAndPaymentData.paymentContent6Part1,
            style: UiConstants.kTextStyleText3.copyWith(
              color: UiConstants.kColorText02,
              height: 1.75,
            ),
            children: [
              TextSpan(
                text: FooterData.number,
                style: UiConstants.kTextStyleText3.copyWith(
                    color: UiConstants.kColorText02,
                    height: 1.75,
                    fontWeight: FontWeight.w700),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async =>
                      await Utils.copyToClipboard(context, FooterData.number),
              ),
              TextSpan(
                text: DeliveryAndPaymentData.paymentContent6Part2,
                style: UiConstants.kTextStyleText3.copyWith(
                  color: UiConstants.kColorText02,
                  height: 1.75,
                ),
              ),
              TextSpan(
                text: FooterData.email,
                style: UiConstants.kTextStyleText3.copyWith(
                    color: UiConstants.kColorText02,
                    height: 1.75,
                    fontWeight: FontWeight.w700),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async =>
                      await Utils.copyToClipboard(context, FooterData.email),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          DeliveryAndPaymentData.paymentContent7,
          style: UiConstants.kTextStyleText3.copyWith(
            color: UiConstants.kColorText02,
            height: 1.75,
          ),
        ),
      ],
    );
  }
}
