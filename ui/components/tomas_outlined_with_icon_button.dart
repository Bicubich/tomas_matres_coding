import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TomasOutlinedWithIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final String text;
  final double? iconWidth;
  final double? iconHeight;
  final Color? iconColor;
  final Color outlineColor;
  final Color textColor;
  final double borderWidth;
  final TextStyle textStyle;
  final EdgeInsets buttonPadding;

  const TomasOutlinedWithIconButton(
      {required this.onPressed,
      required this.text,
      required this.iconPath,
      this.textStyle = UiConstants.kTextStyleText1,
      this.iconWidth,
      this.iconHeight,
      this.iconColor,
      this.outlineColor = UiConstants.kColorPrimary,
      this.textColor = UiConstants.kColorPrimary,
      this.borderWidth = 0.50,
      this.buttonPadding =
          const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () => onPressed(),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color>(
                (states) => Colors.transparent),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) => Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
            minimumSize: MaterialStateProperty.all<Size>(const Size(0, 0)),
            alignment: Alignment.center,
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                side: borderWidth != 0
                    ? BorderSide(width: borderWidth, color: outlineColor)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            elevation: MaterialStateProperty.all<double>(0),
          ),
          child: Padding(
            padding: buttonPadding,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: iconWidth,
                  height: iconHeight,
                  colorFilter: iconColor != null
                      ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                      : null,
                  semanticsLabel: 'Icon',
                ),
                const SizedBox(
                  width: 8,
                  height: 24,
                ),
                Text(text,
                    textAlign: TextAlign.center,
                    style: textStyle.copyWith(color: textColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
