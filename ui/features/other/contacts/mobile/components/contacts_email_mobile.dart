import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_icon_with_text_button.dart';

class ContactsEmailMobile extends StatelessWidget {
  const ContactsEmailMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.kTextContactsEmailTitle.tr(),
          style: UiConstants.kTextStyleText3
              .copyWith(color: UiConstants.kColorText03),
        ),
        const SizedBox(
          height: 16,
        ),
        TomasIconWithTextButton(
          onPressed: () async {
            await Utils.copyToClipboard(context, 'info@tomas-matres.ru');
          },
          iconPath: Paths.contactsEmailIconPath,
          text: 'info@tomas-matres.ru',
        ),
      ],
    );
  }
}
