import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/mobile/components/delivery_info_item_mobile.dart';

class DeliveryMobile extends StatelessWidget {
  final Color backgroundColor;

  DeliveryMobile({required this.backgroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            LocaleKeys.kTextDelivery.tr(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 8,
                color: UiConstants.kColorPrimary,
              ),
              const SizedBox(
                width: 17,
              ),
              Expanded(
                child: Text(
                  LocaleKeys.kTextDeliveryInfoTipText.tr(),
                  style: UiConstants.kTextStyleText3.copyWith(
                    color: UiConstants.kColorText02,
                    height: 1.75,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            LocaleKeys.kTextDeliveryInfoAdditionalInfoText.tr(),
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
    LocaleKeys.kTextDeliveryInfoColumnTitle1.tr(),
    LocaleKeys.kTextDeliveryInfoColumnTitle2.tr(),
    LocaleKeys.kTextDeliveryInfoColumnTitle3.tr(),
    LocaleKeys.kTextDeliveryInfoColumnTitle4.tr(),
    LocaleKeys.kTextDeliveryInfoColumnTitle5.tr(),
    LocaleKeys.kTextDeliveryInfoColumnTitle6.tr(),
  ];

  final List<String> secondRowTexts = [
    LocaleKeys.kTextDeliveryInfoRow2Column1Content.tr(),
    LocaleKeys.kTextDeliveryInfoRow2Column2Content.tr(),
    LocaleKeys.kTextDeliveryInfoRow2Column3Content.tr(),
    LocaleKeys.kTextDeliveryInfoRow2Column4Content.tr(),
    LocaleKeys.kTextDeliveryInfoRow2Column5Content.tr(),
    LocaleKeys.kTextDeliveryInfoRow2Column6Content.tr(),
  ];
}
