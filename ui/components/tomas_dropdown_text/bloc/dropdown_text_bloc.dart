import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/bloc/dropdown_text_event.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/bloc/dropdown_text_state.dart';

class DropdownTextBloc extends Bloc<DropdownTextEvent, DropdownTextState> {
  final ScrollController? scrollController;
  final bool isDropdownVisible;

  DropdownTextBloc({this.scrollController, this.isDropdownVisible = false})
      : super(DropdownTextState(isDropdownVisible: isDropdownVisible)) {
    on<ToggleDropdownEvent>((event, emit) async {
      emit(DropdownTextState(isDropdownVisible: !state.isDropdownVisible));

      if (scrollController != null) {
        await Future.delayed(const Duration(milliseconds: 10)).then((value) {
          if (state.isDropdownVisible) {
            scrollController!.animateTo(
                scrollController!.position.maxScrollExtent,
                duration: const Duration(milliseconds: 155),
                curve: Curves.linear);
          }
        });
      }
    });
  }
}
