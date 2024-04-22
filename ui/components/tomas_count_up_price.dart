import 'package:countup/countup.dart';
import 'package:flutter/material.dart';

class TomasCountUpPrice extends StatelessWidget {
  final double price;
  final TextStyle textStyle;

  const TomasCountUpPrice(
      {super.key, required this.price, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Countup(
          begin: 0,
          end: price,
          style: textStyle,
        ),
        Text(
          ' ₽',
          style: textStyle,
        )
      ],
    );
  }
}
