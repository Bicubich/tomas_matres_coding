import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/data/delivery_and_payment_data.dart';

class PaymentDetailsMobile extends StatelessWidget {
  const PaymentDetailsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: DeliveryAndPaymentData.anotherPaymentContent4,
        style: UiConstants.kTextStyleText4.copyWith(
          color: UiConstants.kColorText02,
          fontWeight: FontWeight.w400,
          height: 1.75,
        ),
        children: [
          TextSpan(
            text: DeliveryAndPaymentData.rAccount,
            style: UiConstants.kTextStyleText4.copyWith(
              color: UiConstants.kColorText02,
              fontWeight: FontWeight.w400,
              height: 1.75,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async => await Utils.copyToClipboard(
                  context, DeliveryAndPaymentData.rAccount),
          ),
          TextSpan(
            text: DeliveryAndPaymentData.anotherPaymentContent5,
            style: UiConstants.kTextStyleText4.copyWith(
              color: UiConstants.kColorText02,
              fontWeight: FontWeight.w400,
              height: 1.75,
            ),
          ),
          TextSpan(
            text: DeliveryAndPaymentData.inn,
            style: UiConstants.kTextStyleText4.copyWith(
              color: UiConstants.kColorText02,
              fontWeight: FontWeight.w400,
              height: 1.75,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async => await Utils.copyToClipboard(
                  context, DeliveryAndPaymentData.inn),
          ),
          TextSpan(
            text: DeliveryAndPaymentData.anotherPaymentContent6,
            style: UiConstants.kTextStyleText4.copyWith(
              color: UiConstants.kColorText02,
              fontWeight: FontWeight.w400,
              height: 1.75,
            ),
          ),
          TextSpan(
            text: DeliveryAndPaymentData.bik,
            style: UiConstants.kTextStyleText4.copyWith(
              color: UiConstants.kColorText02,
              fontWeight: FontWeight.w400,
              height: 1.75,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async => await Utils.copyToClipboard(
                  context, DeliveryAndPaymentData.bik),
          ),
          TextSpan(
            text: DeliveryAndPaymentData.anotherPaymentContent7,
            style: UiConstants.kTextStyleText4.copyWith(
              color: UiConstants.kColorText02,
              fontWeight: FontWeight.w400,
              height: 1.75,
            ),
          ),
          TextSpan(
            text: DeliveryAndPaymentData.ogrn,
            style: UiConstants.kTextStyleText4.copyWith(
              color: UiConstants.kColorText02,
              fontWeight: FontWeight.w400,
              height: 1.75,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async => await Utils.copyToClipboard(
                  context, DeliveryAndPaymentData.ogrn),
          ),
        ],
      ),
    );
  }
}
