import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class DeliveryInfoItemMobile extends StatelessWidget {
  final String title;
  final String content;

  const DeliveryInfoItemMobile({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: UiConstants.kTextStyleHeadline4.copyWith(
              color: UiConstants.kColorText03,
              height: 1.75,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          content,
          style: UiConstants.kTextStyleText3.copyWith(
            color: UiConstants.kColorText02,
            height: 1.75,
          ),
        )
      ],
    );
  }
}
