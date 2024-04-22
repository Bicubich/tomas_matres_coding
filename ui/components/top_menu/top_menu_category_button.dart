import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TopMenuCategoryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onHover;
  final String? iconPath;
  final String text;
  final bool selected;

  const TopMenuCategoryButton(
      {required this.onPressed,
      required this.onHover,
      required this.iconPath,
      required this.text,
      required this.selected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith<EdgeInsets>(
              (states) => const EdgeInsets.all(0)),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
              (states) => UiConstants.kColorBase02),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) =>
              selected ? UiConstants.kColorBase02 : Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
          fixedSize: MaterialStateProperty.resolveWith<Size>(
              (states) => const Size(312, 48)),
          alignment: Alignment.centerLeft),
      onHover: (value) => value ? onHover() : null,
      onPressed: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 32,
                height: 32,
                child: iconPath != null
                    ? CachedNetworkImage(
                        imageUrl: iconPath!,
                        errorWidget: (context, url, error) {
                          return Container(
                            color: UiConstants.kColorBase04,
                          );
                        },
                      )
                    : Container(
                        color: UiConstants.kColorBase01,
                      )),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: UiConstants.kTextStyleText3.copyWith(
                  color: UiConstants.kColorText02,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
