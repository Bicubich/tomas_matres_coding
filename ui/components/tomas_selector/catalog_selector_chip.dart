import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_selector/cubit/selector_cubit.dart';

class CatalogSelectorChip extends StatelessWidget {
  final String text;
  final bool selected;
  final int index;

  const CatalogSelectorChip(
      {required this.text,
      required this.selected,
      required this.index,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () =>
            BlocProvider.of<SelectorCubit>(context).onSelectorItemTap(index),
        child: Container(
          height: 48,
          width: 144,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: index != 0 ? 2 : 0),
          decoration: BoxDecoration(
              color: selected
                  ? UiConstants.kColorBase01
                  : UiConstants.kColorBase02,
              borderRadius: BorderRadius.circular(32)),
          child: Text(
            text,
            style: UiConstants.kTextStyleText2.copyWith(
                color: selected
                    ? UiConstants.kColorText02
                    : UiConstants.kColorText03),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
