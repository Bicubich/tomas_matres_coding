import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/other/contacts/mobile/components/payment_details_mobile.dart';

class ContactsAboutCompanyMobile extends StatelessWidget {
  const ContactsAboutCompanyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          LocaleKeys.kTextContactsCompanyTitle.tr(),
          style: UiConstants.kTextStyleHeadline4
              .copyWith(color: UiConstants.kColorText01),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          LocaleKeys.kTextContactsAddress.tr(),
          style: UiConstants.kTextStyleText4.copyWith(
              color: UiConstants.kColorText02,
              height: 1.75,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 24,
        ),
        InkWell(
          onTap: () async => await Utils.onAddressTap(),
          child: Text(
            LocaleKeys.kTextContactsAddressContent.tr(),
            style: UiConstants.kTextStyleText4.copyWith(
              color: UiConstants.kColorText02,
              fontWeight: FontWeight.w400,
              height: 1.75,
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          LocaleKeys.kTextContactsPaymentData.tr(),
          style: UiConstants.kTextStyleText4.copyWith(
            color: UiConstants.kColorText02,
            fontWeight: FontWeight.w700,
            height: 1.75,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const PaymentDetailsMobile()
      ],
    );
  }
}
