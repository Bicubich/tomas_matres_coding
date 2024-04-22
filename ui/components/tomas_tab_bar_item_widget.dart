import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TabBarItemWidget extends StatelessWidget {
  const TabBarItemWidget(
      {required this.text, super.key, required this.isActive});

  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: Text(
          text,
          style: UiConstants.kTextStyleText2.copyWith(
            color:
                isActive ? UiConstants.kColorBase05 : UiConstants.kColorBase04,
          ),
        ),
      ),
    );
  }
}
