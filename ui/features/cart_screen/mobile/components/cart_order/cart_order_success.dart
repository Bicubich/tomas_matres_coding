import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';

class CartOrderDialogSuccess extends StatelessWidget {
  final String orderNumber;

  const CartOrderDialogSuccess({required this.orderNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.kTextOrderSuccessTitle.tr(),
          style: UiConstants.kTextStyleHeadline3.copyWith(
            color: UiConstants.kColorText01,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          LocaleKeys.kTextOrderSuccessContent.tr(),
          style: UiConstants.kTextStyleText3
              .copyWith(color: UiConstants.kColorText03, height: 1.75),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: LocaleKeys.kTextOrderNumber.tr(),
            style: UiConstants.kTextStyleText3.copyWith(
              color: UiConstants.kColorText03,
            ),
            children: [
              TextSpan(
                text: orderNumber,
                style: UiConstants.kTextStyleText3.copyWith(
                  color: UiConstants.kColorText02,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
