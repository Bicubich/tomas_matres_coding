import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';

class WarrantyScreenMobile extends StatefulWidget {
  const WarrantyScreenMobile({super.key});

  @override
  State<WarrantyScreenMobile> createState() => _WarrantyScreenMobileState();
}

class _WarrantyScreenMobileState extends State<WarrantyScreenMobile> {
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
            LocaleKeys.kTextWarranty.tr(),
            style: UiConstants.kTextStyleHeadline5
                .copyWith(color: UiConstants.kColorText01),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: padding,
          child: RichText(
            text: TextSpan(
              text: LocaleKeys.kTextWarrantyContent1part1.tr(),
              style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText02, fontSize: 16, height: 1.75),
              children: [
                TextSpan(
                  text: LocaleKeys.kTextWarrantyContent1part2.tr(),
                  style: UiConstants.kTextStyleText1.copyWith(
                      color: UiConstants.kColorText02,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 1.75),
                ),
                TextSpan(
                  text: LocaleKeys.kTextWarrantyContent1part3.tr(),
                  style: UiConstants.kTextStyleText1.copyWith(
                      color: UiConstants.kColorText02,
                      fontSize: 16,
                      height: 1.75),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 39,
        ),
        Padding(
          padding: padding,
          child: Text(
            LocaleKeys.kTextWarrantyContent2.tr(),
            style: UiConstants.kTextStyleText1.copyWith(
                color: UiConstants.kColorText02, fontSize: 16, height: 1.75),
          ),
        ),
        const SizedBox(
          height: 39,
        ),
        Padding(
          padding: padding,
          child: RichText(
            text: TextSpan(
              text: LocaleKeys.kTextWarrantyContent3part1.tr(),
              style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText02,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.75),
              children: [
                TextSpan(
                  text: LocaleKeys.kTextWarrantyContent3part2.tr(),
                  style: UiConstants.kTextStyleText1.copyWith(
                      color: UiConstants.kColorText02,
                      fontSize: 16,
                      height: 1.75),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 39,
        ),
        Padding(
          padding: padding,
          child: RichText(
            text: TextSpan(
              text: LocaleKeys.kTextWarrantyContent4part1.tr(),
              style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText02, fontSize: 16, height: 1.75),
              children: [
                TextSpan(
                  text: LocaleKeys.kTextWarrantyContent4part2.tr(),
                  style: UiConstants.kTextStyleText1.copyWith(
                      color: UiConstants.kColorText02,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 1.75),
                ),
                TextSpan(
                  text: LocaleKeys.kTextWarrantyContent4part3.tr(),
                  style: UiConstants.kTextStyleText1.copyWith(
                      color: UiConstants.kColorText02,
                      fontSize: 16,
                      height: 1.75),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        const FooterMobile(),
      ],
    );
  }
}
