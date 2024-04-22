import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TomasFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double borderRadius;
  final TextStyle textStyle;
  final double? height;
  final double? width;
  final EdgeInsets padding;

  const TomasFilledButton(
      {required this.text,
      required this.onPressed,
      this.borderRadius = 8,
      this.textStyle = UiConstants.kTextStyleText3,
      this.height,
      this.width,
      super.key,
      this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => UiConstants.kColorPrimary),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.only(left: 65, right: 65, top: 16, bottom: 16)),
          minimumSize: MaterialStateProperty.all<Size>(const Size(0, 0)),
          alignment: Alignment.center,
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        child: Padding(
          padding: padding,
          child: Text(text,
              textAlign: TextAlign.center,
              style: textStyle.copyWith(color: UiConstants.kColorText04)),
        ),
      ),
    );
  }
}
