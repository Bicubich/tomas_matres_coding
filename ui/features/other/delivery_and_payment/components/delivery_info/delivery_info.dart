import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/components/delivery_info/components/delivery_info_table.dart';

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.kTextDelivery.tr(),
            style: UiConstants.kTextStyleHeadline2.copyWith(
              color: UiConstants.kColorText01,
            )),
        const SizedBox(
          height: 56,
        ),
        const DeliveryInfoTable(),
        const SizedBox(
          height: 56,
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
                style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText02,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          LocaleKeys.kTextDeliveryInfoAdditionalInfoText.tr(),
          style: UiConstants.kTextStyleText1.copyWith(
            color: UiConstants.kColorText02,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 10,
        ),
      ],
    );
  }
}
