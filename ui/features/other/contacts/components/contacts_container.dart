import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class ContactsContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget content;

  const ContactsContainer(
      {required this.width,
      required this.height,
      required this.content,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: UiConstants.kColorBase02,
            borderRadius: BorderRadius.circular(24)),
        padding:
            const EdgeInsets.only(top: 40, left: 40, bottom: 40, right: 48),
        child: content);
  }
}
