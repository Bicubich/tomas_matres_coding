import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';

class CartOrderDialogError extends StatelessWidget {
  const CartOrderDialogError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.kTextOrderErrorTitle.tr(),
          style: UiConstants.kTextStyleHeadline3.copyWith(
            color: UiConstants.kColorText01,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          LocaleKeys.kTextOrderErrorContent.tr(),
          style: UiConstants.kTextStyleText3.copyWith(
            color: UiConstants.kColorText03,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
