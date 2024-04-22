import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_icon_with_text_button.dart';

class ContactsPhoneCard extends StatelessWidget {
  const ContactsPhoneCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 112,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.kTextContactsOrderAndConsultation.tr(),
                  style: UiConstants.kTextStyleText3
                      .copyWith(color: UiConstants.kColorText03),
                ),
                const SizedBox(
                  height: 16,
                ),
                TomasIconWithTextButton(
                  onPressed: () async {
                    await Utils.copyToClipboard(context, '8(925) 337-6011');
                  },
                  iconPath: Paths.contactsPhoneIconPath,
                  text: '8(925) 337-6011',
                ),
                const SizedBox(
                  height: 22,
                ),
                TomasIconWithTextButton(
                  onPressed: () async {
                    await Utils.copyToClipboard(context, '8(903) 562-2290');
                  },
                  iconPath: Paths.contactsPhoneIconPath,
                  text: '8(903) 562-2290',
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 112,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border:
                    Border(left: BorderSide(color: UiConstants.kColorBase03))),
            child: Text(
              LocaleKeys.kTextContactsWorkTime.tr(),
              style: UiConstants.kTextStyleText3
                  .copyWith(color: UiConstants.kColorText03),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
