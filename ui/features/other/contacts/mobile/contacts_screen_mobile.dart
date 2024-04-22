import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/other/contacts/mobile/components/contacts_about_company_mobile.dart';
import 'package:tomas_matres/ui/features/other/contacts/mobile/components/contacts_email_mobile.dart';
import 'package:tomas_matres/ui/features/other/contacts/mobile/components/contacts_phone_mobile.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';

class ContactsScreenMobile extends StatefulWidget {
  const ContactsScreenMobile({super.key});

  @override
  State<ContactsScreenMobile> createState() => _ContactsScreenMobileState();
}

class _ContactsScreenMobileState extends State<ContactsScreenMobile> {
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    return MobileTemplate(
      children: [
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: padding,
          child: Text(
            LocaleKeys.kTextContacts.tr(),
            style: UiConstants.kTextStyleHeadline5.copyWith(
              color: UiConstants.kColorText01,
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: padding,
          child: const ContactsPhoneMobile(),
        ),
        const SizedBox(
          height: 54,
        ),
        Padding(
          padding: padding,
          child: const ContactsEmailMobile(),
        ),
        const SizedBox(
          height: 70,
        ),
        Padding(
          padding: padding,
          child: const ContactsAboutCompanyMobile(),
        ),
        const SizedBox(
          height: 80,
        ),
        const FooterMobile(),
      ],
    );
  }
}
