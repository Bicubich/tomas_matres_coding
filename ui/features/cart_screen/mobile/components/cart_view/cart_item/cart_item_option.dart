import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class CartItemOption extends StatelessWidget {
  final String optionName;
  final String optionValueName;
  final String pricePrefix;
  final String price;

  const CartItemOption(
      {super.key,
      required this.optionName,
      required this.optionValueName,
      required this.pricePrefix,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: RichText(
            text: TextSpan(
              text: '$optionName: ',
              style: UiConstants.kTextStyleText3
                  .copyWith(color: UiConstants.kColorText03),
              children: [
                TextSpan(
                  text: optionValueName,
                  style: UiConstants.kTextStyleText3
                      .copyWith(color: UiConstants.kColorText03),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        RichText(
          text: TextSpan(
            text: '$pricePrefix ',
            style: UiConstants.kTextStyleText3
                .copyWith(color: UiConstants.kColorText05),
            children: [
              TextSpan(
                text: price,
                style: UiConstants.kTextStyleText3
                    .copyWith(color: UiConstants.kColorText05),
              ),
              TextSpan(
                text: ' ₽',
                style: UiConstants.kTextStyleText3
                    .copyWith(color: UiConstants.kColorText05),
              )
            ],
          ),
        )
      ],
    );
  }
}
