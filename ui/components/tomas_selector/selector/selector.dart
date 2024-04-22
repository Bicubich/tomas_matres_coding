import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_selector/cubit/selector_cubit.dart';
import 'package:tomas_matres/ui/components/tomas_selector/selector/selector_chip.dart';

class Selector extends StatefulWidget {
  final double height;
  final double width;

  const Selector(
      {this.height = 56,
      this.width = 298,
      super.key,
      required this.titlesList});

  final List<String> titlesList;

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: UiConstants.kColorBase02,
          borderRadius: BorderRadius.circular(32)),
      padding: const EdgeInsets.all(4),
      child: BlocBuilder<SelectorCubit, SelectorState>(
        builder: (context, state) {
          return Row(
            children: List.generate(
              widget.titlesList.length,
              (index) => SelectorChip(
                text: widget.titlesList[index],
                selected: state.selectedIndex == index,
                index: index,
              ),
            ),
          );
        },
      ),
    );
  }
}
