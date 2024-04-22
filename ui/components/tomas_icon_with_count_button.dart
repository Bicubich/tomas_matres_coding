import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';

class TomasIconWithCountButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final String text;
  final double iconWidth;
  final double iconHeight;
  final Color? iconColor;
  final TextStyle textStyle;
  final Color textColor;

  const TomasIconWithCountButton(
      {required this.onPressed,
      required this.iconPath,
      required this.text,
      this.textStyle = UiConstants.kTextStyleText5,
      this.textColor = UiConstants.kColorText04,
      this.iconWidth = 34,
      this.iconHeight = 34,
      this.iconColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onPressed(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            TomasIconButton(
              onPressed: () => onPressed(),
              width: iconWidth,
              height: iconHeight,
              iconPath: iconPath,
            ),
            Positioned(
              top: MediaQuery.of(context).size.width >
                      UiConstants.minDesktopWidth
                  ? 8
                  : 3,
              right: text.length == 1 ? 6 : 4,
              child: Text(
                text,
                style: UiConstants.kTextStyleText5
                    .copyWith(color: UiConstants.kColorText04),
              ),
            )
          ],
        ),
      ),
    );
  }
}
