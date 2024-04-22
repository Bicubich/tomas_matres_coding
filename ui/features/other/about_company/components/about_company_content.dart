import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';

class AboutCompanyContent extends StatelessWidget {
  const AboutCompanyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.kTextAboutCompany.tr(),
            style: UiConstants.kTextStyleHeadline1.copyWith(
              color: UiConstants.kColorText01,
            )),
        const SizedBox(
          height: 48,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            Paths.aboutCompanyImagePath,
            width: 1840,
            height: 529,
            fit: BoxFit.fitHeight,
            color: UiConstants.kColorBase02,
            colorBlendMode: BlendMode.modulate,
          ),
        ),
        const SizedBox(
          height: 72,
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 1171),
          child: Column(children: [
            Text(LocaleKeys.kTextAboutCompanyTitle.tr(),
                style: UiConstants.kTextStyleHeadline2.copyWith(
                  color: UiConstants.kColorText01,
                )),
            const SizedBox(
              height: 40,
            ),
            Text(LocaleKeys.kTextAboutCompanyContent1.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText01,
                )),
            const SizedBox(
              height: 40,
            ),
            Text(LocaleKeys.kTextAboutCompanyContent2.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText01,
                )),
            const SizedBox(
              height: 40,
            ),
            Text(LocaleKeys.kTextAboutCompanyContent3.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText01,
                )),
            const SizedBox(
              height: 40,
            ),
            Text(LocaleKeys.kTextAboutCompanyContent4.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText01,
                )),
          ]),
        )
      ],
    );
  }
}
