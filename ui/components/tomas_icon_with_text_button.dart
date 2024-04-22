import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TomasIconWithTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final String text;
  final TextStyle textStyle;
  final double iconWidth;
  final double iconHeight;
  final Color? iconColor;
  final Color textColor;
  final bool isTrailingIcon;
  final MainAxisAlignment alignment;
  final bool expand;

  const TomasIconWithTextButton(
      {required this.onPressed,
      required this.iconPath,
      required this.text,
      this.textStyle = UiConstants.kTextStyleHeadline6,
      this.textColor = UiConstants.kColorText01,
      this.iconWidth = 24,
      this.iconHeight = 24,
      this.iconColor,
      this.isTrailingIcon = false,
      this.alignment = MainAxisAlignment.start,
      this.expand = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith<EdgeInsets>(
            (states) => const EdgeInsets.all(0)),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
      ),
      onPressed: () => onPressed(),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: alignment,
        children: createButtonContent(),
      ),
    );
  }

  List<Widget> createButtonContent() {
    List<Widget> widgets = [
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
        width: 16,
      ),
      Text(text,
          style: textStyle.copyWith(
            color: textColor,
          )),
    ];

    if (isTrailingIcon) {
      return widgets.reversed.toList();
    } else {
      return widgets;
    }
  }
}
