import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TomasFilledIconWithTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onHover;
  final VoidCallback? onHoverEnd;
  final String iconPath;
  final String text;
  final TextStyle textStyle;
  final bool active;
  final Color disabledButtonColor;
  final Color disabledTextColor;
  final Color disabledIconColor;
  final bool asSmallAsPossible;
  final double? iconWidth;
  final double? iconHeight;
  final double? buttonWidth;
  final EdgeInsets buttonPadding;

  const TomasFilledIconWithTextButton(
      {required this.onPressed,
      required this.iconPath,
      required this.text,
      this.textStyle = UiConstants.kTextStyleText3,
      this.active = true,
      this.disabledButtonColor = Colors.transparent,
      this.disabledTextColor = UiConstants.kColorText02,
      this.disabledIconColor = UiConstants.kColorText02,
      this.asSmallAsPossible = true,
      this.onHover,
      this.onHoverEnd,
      this.iconHeight = 24,
      this.iconWidth = 24,
      super.key,
      this.buttonWidth,
      this.buttonPadding =
          const EdgeInsets.symmetric(horizontal: 22, vertical: 12)});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => onHover != null ? onHover!() : () {},
      onExit: (event) => onHoverEnd != null ? onHoverEnd!() : () {},
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith<EdgeInsets>(
                (states) => const EdgeInsets.all(0)),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
                (states) => Colors.transparent),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) =>
                    active ? UiConstants.kColorPrimary : disabledButtonColor),
            splashFactory: NoSplash.splashFactory,
            elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    )),
          ),
          onPressed: () => onPressed(),
          child: Container(
            padding: buttonPadding,
            child: Row(
              mainAxisSize:
                  asSmallAsPossible ? MainAxisSize.min : MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: iconWidth,
                  child: SvgPicture.asset(
                    iconPath,
                    width: iconWidth,
                    height: iconHeight,
                    semanticsLabel: 'Icon',
                    colorFilter: ColorFilter.mode(
                        active ? UiConstants.kColorBase01 : disabledTextColor,
                        BlendMode.srcIn),
                  ),
                ),
                const SizedBox(
                  width: 8,
                  height: 24,
                ),
                Text(text,
                    style: textStyle.copyWith(
                      color:
                          active ? UiConstants.kColorBase01 : disabledTextColor,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
