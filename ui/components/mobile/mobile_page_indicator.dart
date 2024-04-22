import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class MobilePageIndicator extends StatelessWidget {
  final PageController controller;
  final int pageCount;

  const MobilePageIndicator(
      {required this.controller, required this.pageCount, super.key});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: pageCount,
      effect: const ScrollingDotsEffect(
          dotColor: UiConstants.kColorBase03,
          activeDotColor: UiConstants.kColorLink,
          paintStyle: PaintingStyle.fill,
          activeDotScale: 1.1,
          dotWidth: 8,
          dotHeight: 8,
          spacing: 16),
    );
  }
}
