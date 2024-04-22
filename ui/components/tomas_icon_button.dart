import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TomasIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final double width;
  final double height;
  final Color? iconColor;

  const TomasIconButton(
      {required this.onPressed,
      required this.iconPath,
      this.width = 24,
      this.height = 24,
      this.iconColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
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
        child: SvgPicture.asset(
          iconPath,
          semanticsLabel: 'Icon',
          width: width,
          height: height,
          colorFilter: iconColor != null
              ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }
}
