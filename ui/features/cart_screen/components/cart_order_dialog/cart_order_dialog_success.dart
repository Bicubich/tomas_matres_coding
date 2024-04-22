import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';

class CartOrderDialogSuccess extends StatelessWidget {
  final String orderNumber;

  const CartOrderDialogSuccess({required this.orderNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned(
          top: 34,
          right: 32,
          child: TomasIconButton(
            onPressed: () => Navigator.pop(context),
            iconPath: Paths.xIconPath,
            width: 20,
            height: 20,
            iconColor: UiConstants.kColorBase05,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.kTextOrderSuccessTitle.tr(),
                style: UiConstants.kTextStyleHeadline5.copyWith(
                  color: UiConstants.kColorText01,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                LocaleKeys.kTextOrderSuccessContent.tr(),
                style: UiConstants.kTextStyleText2.copyWith(
                  color: UiConstants.kColorText03,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: LocaleKeys.kTextOrderNumber.tr(),
                      style: UiConstants.kTextStyleText2.copyWith(
                        color: UiConstants.kColorText03,
                      ),
                      children: [
                        TextSpan(
                            text: orderNumber,
                            style: UiConstants.kTextStyleText2.copyWith(
                              color: UiConstants.kColorText02,
                            )),
                      ]))
            ],
          ),
        )
      ],
    );
  }
}
