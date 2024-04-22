import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_icon_with_text_button.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/info_dropdown/bloc/total_dropdown_item_bloc.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/info_dropdown/bloc/total_dropdown_item_event.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/info_dropdown/bloc/total_dropdown_item_state.dart';

class SummaryColumnInfoDropdown extends StatelessWidget {
  const SummaryColumnInfoDropdown(
      {super.key, required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TotalPriceBloc, TotalPriceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TomasIconWithTextButton(
              onPressed: () =>
                  context.read<TotalPriceBloc>().add(ToggleDropdownEvent()),
              iconPath: state.isDropdownVisible
                  ? Paths.arrowUpIconIconPath
                  : Paths.arrowDownIconIconPath,
              text: title,
              textStyle: UiConstants.kTextStyleHeadline4,
              textColor: UiConstants.kColorText02,
              expand: true,
            ),
            Visibility(
              visible: state.isDropdownVisible,
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  body,
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
