import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/data/delivery_and_payment_data.dart';

class SelfDeliveryInfo extends StatelessWidget {
  const SelfDeliveryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.kTextDeliveryInfoSelfDelivery.tr(),
          style: UiConstants.kTextStyleHeadline2.copyWith(
            color: UiConstants.kColorText01,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        RichText(
          text: TextSpan(
            text: '${LocaleKeys.kTextDeliveryInfoSelfDelivery.tr()}: ',
            style: UiConstants.kTextStyleText1.copyWith(
              color: UiConstants.kColorText02,
            ),
            children: [
              TextSpan(
                text: DeliveryAndPaymentData
                    .kTextDeliveryInfoSelfDeliveryContentAddress,
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText02,
                    fontWeight: FontWeight.w700),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async => await Utils.onAddressTap(),
              ),
              TextSpan(
                text: LocaleKeys.kTextDeliveryInfoSelfDeliveryContent.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText02,
                ),
              ),
              TextSpan(
                text: DeliveryAndPaymentData
                    .kTextDeliveryInfoSelfDeliveryContentPhone,
                style: UiConstants.kTextStyleText1.copyWith(
                    color: UiConstants.kColorText02,
                    fontWeight: FontWeight.w700),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async => await Utils.copyToClipboard(
                      context,
                      DeliveryAndPaymentData
                          .kTextDeliveryInfoSelfDeliveryContentPhone),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
