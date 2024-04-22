import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/common/navigation/navigation_widget.dart';
import 'package:tomas_matres/ui/features/other/warranty/mobile/warranty_screen_mobile.dart';
import 'package:tomas_matres/ui/features/template/template.dart';

class WarrantyScreen extends StatefulWidget {
  const WarrantyScreen({super.key});

  @override
  State<WarrantyScreen> createState() => _WarrantyScreenState();
}

class _WarrantyScreenState extends State<WarrantyScreen> {
  final ScrollController scrollController = ScrollController();
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 40);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < UiConstants.minDesktopWidth) {
      return const WarrantyScreenMobile();
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
              child: Text(LocaleKeys.kTextWarranty.tr(),
                  style: UiConstants.kTextStyleHeadline1.copyWith(
                    color: UiConstants.kColorText01,
                  )),
            ),
            const SizedBox(
              height: 56,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 1171,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: padding,
                          child: RichText(
                              text: TextSpan(
                                  text: LocaleKeys.kTextWarrantyContent1part1
                                      .tr(),
                                  style: UiConstants.kTextStyleText1.copyWith(
                                    color: UiConstants.kColorText02,
                                  ),
                                  children: [
                                TextSpan(
                                  text: LocaleKeys.kTextWarrantyContent1part2
                                      .tr(),
                                  style: UiConstants.kTextStyleText1.copyWith(
                                      color: UiConstants.kColorText02,
                                      fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: LocaleKeys.kTextWarrantyContent1part3
                                      .tr(),
                                  style: UiConstants.kTextStyleText1.copyWith(
                                    color: UiConstants.kColorText02,
                                  ),
                                )
                              ]))),
                      const SizedBox(
                        height: 39,
                      ),
                      Padding(
                          padding: padding,
                          child: Text(
                            LocaleKeys.kTextWarrantyContent2.tr(),
                            style: UiConstants.kTextStyleText1.copyWith(
                              color: UiConstants.kColorText02,
                            ),
                          )),
                      const SizedBox(
                        height: 39,
                      ),
                      Padding(
                          padding: padding,
                          child: RichText(
                              text: TextSpan(
                                  text: LocaleKeys.kTextWarrantyContent3part1
                                      .tr(),
                                  style: UiConstants.kTextStyleText1.copyWith(
                                      color: UiConstants.kColorText02,
                                      fontWeight: FontWeight.w700),
                                  children: [
                                TextSpan(
                                  text: LocaleKeys.kTextWarrantyContent3part2
                                      .tr(),
                                  style: UiConstants.kTextStyleText1.copyWith(
                                    color: UiConstants.kColorText02,
                                  ),
                                )
                              ]))),
                      const SizedBox(
                        height: 39,
                      ),
                      Padding(
                          padding: padding,
                          child: RichText(
                              text: TextSpan(
                                  text: LocaleKeys.kTextWarrantyContent4part1
                                      .tr(),
                                  style: UiConstants.kTextStyleText1.copyWith(
                                    color: UiConstants.kColorText02,
                                  ),
                                  children: [
                                TextSpan(
                                  text: LocaleKeys.kTextWarrantyContent4part2
                                      .tr(),
                                  style: UiConstants.kTextStyleText1.copyWith(
                                      color: UiConstants.kColorText02,
                                      fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: LocaleKeys.kTextWarrantyContent4part3
                                      .tr(),
                                  style: UiConstants.kTextStyleText1.copyWith(
                                    color: UiConstants.kColorText02,
                                  ),
                                )
                              ]))),
                    ],
                  ),
                ),
              ],
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
