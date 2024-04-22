import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TopMenuCategoryButtonMobile extends StatelessWidget {
  final VoidCallback onPressed;
  final String? iconPath;
  final String? suffixIcon;
  final String text;

  const TopMenuCategoryButtonMobile(
      {required this.onPressed,
      this.iconPath,
      required this.text,
      this.suffixIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith<EdgeInsets>(
            (states) => const EdgeInsets.all(0)),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (states) => UiConstants.kColorBase02),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
        fixedSize: MaterialStateProperty.resolveWith<Size>(
            (states) => const Size(312, 48)),
        alignment: Alignment.centerLeft,
      ),
      onPressed: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (iconPath != null)
              SizedBox(
                  width: 32,
                  height: 32,
                  child: CachedNetworkImage(
                    imageUrl: iconPath!,
                    errorWidget: (context, url, error) {
                      return Container(
                        color: UiConstants.kColorBase04,
                      );
                    },
                  )),
            if (iconPath != null) const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: UiConstants.kTextStyleText3.copyWith(
                  color: UiConstants.kColorText02,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (suffixIcon != null) const Expanded(child: SizedBox.expand()),
            if (suffixIcon != null)
              SvgPicture.asset(
                suffixIcon!,
                semanticsLabel: 'Icon',
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                    UiConstants.kColorBase03, BlendMode.srcIn),
              ),
          ],
        ),
      ),
    );
  }
}
