import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_icon_with_text_button.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/bloc/dropdown_text_bloc.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/bloc/dropdown_text_event.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_text/bloc/dropdown_text_state.dart';

class TomasDropdownText extends StatelessWidget {
  const TomasDropdownText(
      {super.key,
      required this.title,
      required this.body,
      this.textStyle = UiConstants.kTextStyleHeadline4,
      this.textColor = UiConstants.kColorText02,
      this.bodyPadding = const EdgeInsets.only(top: 16)});

  final String title;
  final Widget body;
  final TextStyle textStyle;
  final Color textColor;
  final EdgeInsets bodyPadding;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownTextBloc, DropdownTextState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TomasIconWithTextButton(
              onPressed: () =>
                  context.read<DropdownTextBloc>().add(ToggleDropdownEvent()),
              iconPath: state.isDropdownVisible
                  ? Paths.arrowUpIconIconPath
                  : Paths.arrowDownIconIconPath,
              text: title,
              textStyle: textStyle,
              textColor: textColor,
              expand: true,
            ),
            Visibility(
              visible: state.isDropdownVisible,
              child: Padding(
                padding: bodyPadding,
                child: body,
              ),
            ),
          ],
        );
      },
    );
  }
}
