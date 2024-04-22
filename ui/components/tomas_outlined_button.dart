import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TomasOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color outlineColor;
  final Color textColor;
  final double borderWidth;
  final TextStyle textStyle;

  const TomasOutlinedButton(
      {required this.onPressed,
      required this.text,
      this.outlineColor = UiConstants.kColorPrimary,
      this.textColor = UiConstants.kColorPrimary,
      this.borderWidth = 0.50,
      this.textStyle = UiConstants.kTextStyleText1,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) => Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.only(left: 40, right: 40, top: 16, bottom: 16)),
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
      child: Text(text,
          textAlign: TextAlign.center,
          style: textStyle.copyWith(color: textColor, height: 1)),
    );
  }
}
