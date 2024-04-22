import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';

class TomasSearchTextField extends StatelessWidget {
  final TextEditingController controller;

  const TomasSearchTextField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            fillColor: UiConstants.kColorBase02,
            filled: true,
            hintText: LocaleKeys.kTextSearchTextFieldHint.tr(),
            hintStyle: UiConstants.kTextStyleText1
                .copyWith(color: UiConstants.kColorText03),
            contentPadding:
                const EdgeInsets.only(top: 18.37, bottom: 15.62, left: 32),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 32, left: 5),
              child: SvgPicture.asset(
                Paths.searchIconPath,
                width: 32,
                height: 32,
                semanticsLabel: 'Icon',
              ),
            ),
            border: InputBorder.none),
        style: UiConstants.kTextStyleDate
            .copyWith(color: UiConstants.kColorText02),
        cursorColor: UiConstants.kColorText02,
      ),
    );
  }
}
