import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/data/delivery_and_payment_data.dart';

class AnotherPaymentContent extends StatelessWidget {
  const AnotherPaymentContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.kTextAnotherPaymentOption.tr(),
            style: UiConstants.kTextStyleHeadline3.copyWith(
              color: UiConstants.kColorText01,
            )),
        const SizedBox(
          height: 38,
        ),
        Text(DeliveryAndPaymentData.anotherPaymentContent1,
            style: UiConstants.kTextStyleText1.copyWith(
              color: UiConstants.kColorText02,
            )),
        const SizedBox(
          height: 42,
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
              child: Text(DeliveryAndPaymentData.anotherPaymentContent2,
                  style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText02,
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 42,
        ),
        Text(DeliveryAndPaymentData.anotherPaymentContent3,
            style: UiConstants.kTextStyleText1.copyWith(
                color: UiConstants.kColorText02, fontWeight: FontWeight.w700)),
        const SizedBox(
          height: 16,
        ),
        RichText(
          text: TextSpan(
            text: DeliveryAndPaymentData.anotherPaymentContent4,
            style: UiConstants.kTextStyleText1.copyWith(
                color: UiConstants.kColorText02, fontWeight: FontWeight.w400),
            children: [
              TextSpan(
                text: DeliveryAndPaymentData.rAccount,
                style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText02,
                  fontWeight: FontWeight.w700,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async => await Utils.copyToClipboard(
                      context, DeliveryAndPaymentData.rAccount),
              ),
              TextSpan(
                text: DeliveryAndPaymentData.anotherPaymentContent5,
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText02,
                    fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: DeliveryAndPaymentData.inn,
                style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText02,
                  fontWeight: FontWeight.w700,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async => await Utils.copyToClipboard(
                      context, DeliveryAndPaymentData.inn),
              ),
              TextSpan(
                text: DeliveryAndPaymentData.anotherPaymentContent6,
                style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText02,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: DeliveryAndPaymentData.bik,
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText02,
                    fontWeight: FontWeight.w700),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async => await Utils.copyToClipboard(
                      context, DeliveryAndPaymentData.bik),
              ),
              TextSpan(
                text: DeliveryAndPaymentData.anotherPaymentContent7,
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText02,
                    fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: DeliveryAndPaymentData.ogrn,
                style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText02,
                  fontWeight: FontWeight.w700,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async => await Utils.copyToClipboard(
                      context, DeliveryAndPaymentData.ogrn),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
