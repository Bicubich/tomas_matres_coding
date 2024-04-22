import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TomasTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color foregroundColor;
  final TextStyle textStyle;
  final bool selected;
  final bool disabled;

  const TomasTextButton(
      {required this.onPressed,
      required this.text,
      this.foregroundColor = UiConstants.kColorText03,
      this.textStyle = UiConstants.kTextStyleText3,
      this.selected = false,
      this.disabled = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Colors.transparent),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (selected ||
              (states.contains(MaterialState.hovered) && !disabled)) {
            return UiConstants.kColorLinkHover;
          }
          return foregroundColor;
        }),
        mouseCursor: MaterialStateProperty.resolveWith<MouseCursor>(
            (Set<MaterialState> states) {
          if (disabled) {
            return SystemMouseCursors.basic;
          } else {
            return SystemMouseCursors.click;
          }
        }),
        splashFactory: NoSplash.splashFactory,
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all<Size>(const Size(0, 0)),
        alignment: Alignment.centerLeft,
      ),
      child: Text(
        text,
        style: textStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
