import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/data/delivery_and_payment_data.dart';

class ContactsAboutCompanyCard extends StatelessWidget {
  const ContactsAboutCompanyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            LocaleKeys.kTextContactsCompanyTitle.tr(),
            style: UiConstants.kTextStyleHeadline6
                .copyWith(color: UiConstants.kColorText01),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.kTextContactsAddress.tr(),
            style: UiConstants.kTextStyleText4
                .copyWith(color: UiConstants.kColorText02),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () async => await Utils.onAddressTap(),
            child: Text(
              LocaleKeys.kTextContactsAddressContent.tr(),
              style: UiConstants.kTextStyleText4.copyWith(
                  color: UiConstants.kColorText03, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            LocaleKeys.kTextContactsPaymentData.tr(),
            style: UiConstants.kTextStyleText4
                .copyWith(color: UiConstants.kColorText02),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            text: TextSpan(
              text: DeliveryAndPaymentData.anotherPaymentContent4,
              style: UiConstants.kTextStyleText4
                  .copyWith(color: UiConstants.kColorText03),
              children: [
                TextSpan(
                  text: DeliveryAndPaymentData.rAccount,
                  style: UiConstants.kTextStyleText4.copyWith(
                    color: UiConstants.kColorText03,
                    fontWeight: FontWeight.w700,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async => await Utils.copyToClipboard(
                        context, DeliveryAndPaymentData.rAccount),
                ),
                TextSpan(
                  text: DeliveryAndPaymentData.anotherPaymentContent5,
                  style: UiConstants.kTextStyleText4
                      .copyWith(color: UiConstants.kColorText03),
                ),
                TextSpan(
                  text: DeliveryAndPaymentData.inn,
                  style: UiConstants.kTextStyleText4.copyWith(
                    color: UiConstants.kColorText03,
                    fontWeight: FontWeight.w700,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async => await Utils.copyToClipboard(
                        context, DeliveryAndPaymentData.inn),
                ),
                TextSpan(
                  text: DeliveryAndPaymentData.anotherPaymentContent6,
                  style: UiConstants.kTextStyleText4
                      .copyWith(color: UiConstants.kColorText03),
                ),
                TextSpan(
                  text: DeliveryAndPaymentData.bik,
                  style: UiConstants.kTextStyleText4.copyWith(
                      color: UiConstants.kColorText03,
                      fontWeight: FontWeight.w700),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async => await Utils.copyToClipboard(
                        context, DeliveryAndPaymentData.bik),
                ),
                TextSpan(
                  text: DeliveryAndPaymentData.anotherPaymentContent7,
                  style: UiConstants.kTextStyleText4
                      .copyWith(color: UiConstants.kColorText03),
                ),
                TextSpan(
                  text: DeliveryAndPaymentData.ogrn,
                  style: UiConstants.kTextStyleText4.copyWith(
                    color: UiConstants.kColorText03,
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
      ),
    );
  }
}
