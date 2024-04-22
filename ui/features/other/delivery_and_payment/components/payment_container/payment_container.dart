import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class PaymentContainer extends StatelessWidget {
  final Widget content;

  const PaymentContainer({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: UiConstants.kColorBase02,
            borderRadius: BorderRadius.circular(24)),
        padding:
            const EdgeInsets.only(top: 40, left: 42, bottom: 40, right: 42),
        child: content);
  }
}
