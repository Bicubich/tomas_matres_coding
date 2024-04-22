import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/mobile/components/delivery_info_item_mobile.dart';

class ServiceAssemblyMobile extends StatelessWidget {
  ServiceAssemblyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: UiConstants.kColorBase02,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            LocaleKeys.kTextAssembly.tr(),
            style: UiConstants.kTextStyleHeadline4.copyWith(
              color: UiConstants.kColorText01,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: UiConstants.kColorBase03,
          ),
          ListView.builder(
            itemCount: firstRowTexts.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  DeliveryInfoItemMobile(
                    title: firstRowTexts[index],
                    content: secondRowTexts[index],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: UiConstants.kColorBase03,
                  ),
                ],
              );
            }),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            LocaleKeys.kTextAssemblyInfoContent.tr(),
            style: UiConstants.kTextStyleText3.copyWith(
              color: UiConstants.kColorText02,
              height: 1.75,
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  final List<String> firstRowTexts = [
    LocaleKeys.kTextAssemblyInfoColumnTitle1.tr(),
    LocaleKeys.kTextAssemblyInfoColumnTitle2.tr(),
    LocaleKeys.kTextAssemblyInfoColumnTitle3.tr(),
  ];

  final List<String> secondRowTexts = [
    LocaleKeys.kTextAssemblyInfoRow2Column1Content.tr(),
    LocaleKeys.kTextAssemblyInfoRow2Column2Content.tr(),
    LocaleKeys.kTextAssemblyInfoRow2Column3Content.tr(),
  ];
}
