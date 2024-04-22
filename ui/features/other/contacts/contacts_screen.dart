import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/common/navigation/navigation_widget.dart';
import 'package:tomas_matres/ui/features/other/contacts/components/contacts_about_company_card.dart';
import 'package:tomas_matres/ui/features/other/contacts/components/contacts_container.dart';
import 'package:tomas_matres/ui/features/other/contacts/components/contacts_email_card.dart';
import 'package:tomas_matres/ui/features/other/contacts/components/contacts_phone_card.dart';
import 'package:tomas_matres/ui/features/other/contacts/mobile/contacts_screen_mobile.dart';
import 'package:tomas_matres/ui/features/template/template.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final ScrollController scrollController = ScrollController();
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 40);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < UiConstants.minDesktopWidth) {
      return const ContactsScreenMobile();
    }

    return PageTemplate(
      body: Expanded(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: Utils.calculatePadding(context)),
          controller: scrollController,
          shrinkWrap: true,
          children: [
            const NavigationWidget(),
            Padding(
              padding: padding,
              child: Text(LocaleKeys.kTextContacts.tr(),
                  style: UiConstants.kTextStyleHeadline1.copyWith(
                    color: UiConstants.kColorText01,
                  )),
            ),
            const SizedBox(
              height: 49,
            ),
            Padding(
              padding: padding,
              child: const SizedBox(
                height: 499,
                width: 1060,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ContactsContainer(
                          height: 192,
                          width: 592,
                          content: ContactsPhoneCard(),
                        ),
                        SizedBox(
                          width: 32,
                        ),
                        ContactsContainer(
                          height: 192,
                          width: 436,
                          content: ContactsEmailCard(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    ContactsContainer(
                      height: 275,
                      width: 1060,
                      content: ContactsAboutCompanyCard(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Footer(
              scrollController: scrollController,
            )
          ],
        ),
      ),
    );
  }
}
