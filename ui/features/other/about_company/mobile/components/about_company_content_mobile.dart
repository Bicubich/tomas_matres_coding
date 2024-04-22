import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';

class AboutCompanyContentMobile extends StatelessWidget {
  const AboutCompanyContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(LocaleKeys.kTextAboutCompany.tr(),
            style: UiConstants.kTextStyleHeadline5.copyWith(
              color: UiConstants.kColorText01,
            )),
        const SizedBox(
          height: 32,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            Paths.aboutCompanyImagePath,
            height: 160.w,
            fit: BoxFit.cover,
            color: UiConstants.kColorBase02,
            colorBlendMode: BlendMode.modulate,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 1171),
          child: Column(children: [
            Text(LocaleKeys.kTextAboutCompanyTitle.tr(),
                style: UiConstants.kTextStyleHeadline5.copyWith(
                  color: UiConstants.kColorText01,
                )),
            const SizedBox(
              height: 40,
            ),
            Text(LocaleKeys.kTextAboutCompanyContent1.tr(),
                style: UiConstants.kTextStyleText3
                    .copyWith(color: UiConstants.kColorText01, height: 1.5)),
            const SizedBox(
              height: 24,
            ),
            Text(LocaleKeys.kTextAboutCompanyContent2.tr(),
                style: UiConstants.kTextStyleText3
                    .copyWith(color: UiConstants.kColorText01, height: 1.5)),
            const SizedBox(
              height: 24,
            ),
            Text(LocaleKeys.kTextAboutCompanyContent3.tr(),
                style: UiConstants.kTextStyleText3
                    .copyWith(color: UiConstants.kColorText01, height: 1.5)),
            const SizedBox(
              height: 24,
            ),
            Text(LocaleKeys.kTextAboutCompanyContent4.tr(),
                style: UiConstants.kTextStyleText3
                    .copyWith(color: UiConstants.kColorText01, height: 1.5)),
          ]),
        )
      ],
    );
  }
}
