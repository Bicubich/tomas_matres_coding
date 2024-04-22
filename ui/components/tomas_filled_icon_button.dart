import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TomasFilledIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onHover;
  final VoidCallback? onHoverEnd;
  final String iconPath;
  final TextStyle textStyle;
  final bool active;
  final Color disabledButtonColor;
  final Color disabledTextColor;
  final Color disabledIconColor;
  final bool asSmallAsPossible;
  final double? iconWidth;
  final double? iconHeight;
  final double? buttonWidth;
  final double? buttonHeight;
  final EdgeInsets buttonPadding;

  const TomasFilledIconButton(
      {required this.onPressed,
      required this.iconPath,
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
      this.buttonHeight,
      this.buttonPadding =
          const EdgeInsets.symmetric(horizontal: 22, vertical: 12)});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => onHover != null ? onHover!() : () {},
      onExit: (event) => onHoverEnd != null ? onHoverEnd!() : () {},
      child: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
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
        ),
      ),
    );
  }
}
