import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TomasNextPreviousButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const TomasNextPreviousButtons(
      {required this.onPrevious, required this.onNext, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onPrevious(),
            child: Container(
              width: 56,
              height: 56,
              decoration: const ShapeDecoration(
                color: UiConstants.kColorBase01,
                shape: OvalBorder(
                  side:
                      BorderSide(width: 0.50, color: UiConstants.kColorBase04),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 35,
                  color: UiConstants.kColorBase04,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onNext(),
            child: Container(
              width: 56,
              height: 56,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(
                  side: BorderSide(
                    width: 0.50,
                    color: UiConstants.kColorBase04,
                  ),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 35,
                  color: UiConstants.kColorBase04,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
