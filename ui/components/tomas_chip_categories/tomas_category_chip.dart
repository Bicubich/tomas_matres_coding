import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TomasCategoryChip extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isActive;
  final Color inActiveTextColor;
  final Color activeTextColor;
  final Color backgroundColor;
  final Color? activeBackgroundColor;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final double chipRadius;

  const TomasCategoryChip(
      {required this.title,
      required this.onTap,
      required this.isActive,
      super.key,
      this.backgroundColor = UiConstants.kColorBase01,
      this.activeBackgroundColor,
      this.inActiveTextColor = UiConstants.kColorText05,
      this.activeTextColor = UiConstants.kColorText01,
      this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      this.textStyle = UiConstants.kTextStyleHeadline3,
      this.chipRadius = 32});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith<EdgeInsets>(
            (states) => const EdgeInsets.all(0)),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) =>
            activeBackgroundColor != null && isActive
                ? activeBackgroundColor!
                : backgroundColor),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            if (isActive) {
              return activeTextColor;
            }
            return UiConstants.kColorLinkHover;
          } else {
            if (isActive) {
              return activeTextColor;
            } else {
              return inActiveTextColor;
            }
          }
        }),
        splashFactory: NoSplash.splashFactory,
        elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
            (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(chipRadius),
                )),
      ),
      onPressed: () => onTap(),
      child: Container(padding: padding, child: Text(title, style: textStyle)),
    );
  }
}
