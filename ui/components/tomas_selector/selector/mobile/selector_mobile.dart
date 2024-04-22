import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_selector/cubit/selector_cubit.dart';
import 'package:tomas_matres/ui/components/tomas_selector/selector/mobile/selector_chip_mobile.dart';

class SelectorMobile extends StatefulWidget {
  const SelectorMobile({super.key, required this.titlesList});

  final List<String> titlesList;

  @override
  State<SelectorMobile> createState() => _SelectorState();
}

class _SelectorState extends State<SelectorMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 298,
      height: 56,
      decoration: BoxDecoration(
          color: UiConstants.kColorBase02,
          borderRadius: BorderRadius.circular(32)),
      padding: const EdgeInsets.all(4),
      child: BlocBuilder<SelectorCubit, SelectorState>(
        builder: (context, state) {
          return Row(
            children: List.generate(
              widget.titlesList.length,
              (index) => SelectorChipMobile(
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
