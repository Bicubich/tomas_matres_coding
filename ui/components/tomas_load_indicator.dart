import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TomasLoadIndicator extends StatelessWidget {
  const TomasLoadIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: UiConstants.kColorPrimary,
      ),
    );
  }
}
