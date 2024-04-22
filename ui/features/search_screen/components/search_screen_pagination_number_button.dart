import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class SearchScreenPaginationNumberButton extends StatelessWidget {
  final int index;
  final int activePage;
  final NumberPaginatorController controller;
  final GlobalKey productViewGlobalKey;

  const SearchScreenPaginationNumberButton({
    super.key,
    required this.index,
    required this.activePage,
    required this.controller,
    required this.productViewGlobalKey,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (activePage - 1 == index) {
            return;
          }

          controller.navigateToPage(index);

          if (productViewGlobalKey.currentContext != null) {
            Scrollable.ensureVisible(productViewGlobalKey.currentContext!);
          }
        },
        style: ButtonStyle(
          shape:
              MaterialStateProperty.all<OutlinedBorder?>(const CircleBorder()),
          backgroundColor: MaterialStateProperty.all<Color?>(
              activePage - 1 == index
                  ? UiConstants.kColorBase02
                  : UiConstants.kColorBase01),
          foregroundColor: MaterialStateProperty.all<Color?>(
              activePage - 1 == index
                  ? UiConstants.kColorBase04
                  : UiConstants.kColorBase02),
          overlayColor: MaterialStateProperty.all<Color?>(
              activePage - 1 == index
                  ? UiConstants.kColorBase02
                  : UiConstants.kColorBase02),
        ),
        child: Text((index + 1).toString(),
            style: UiConstants.kTextStyleText1.copyWith(
              color: UiConstants.kColorText03,
            )));
  }
}
