import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_text_button.dart';

class ProductSortItem extends StatelessWidget {
  const ProductSortItem(
      {super.key,
      required this.text,
      required this.index,
      required this.onTap,
      required this.isSelected});

  final String text;
  final int index;
  final bool isSelected;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return TomasTextButton(
      text: text,
      textStyle: UiConstants.kTextStyleText2,
      foregroundColor: UiConstants.kColorText03,
      selected: isSelected,
      onPressed: () => onTap(index),
    );
  }
}
