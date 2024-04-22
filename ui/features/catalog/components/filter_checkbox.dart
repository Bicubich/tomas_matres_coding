import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_text_button.dart';

class FilterCheckbox extends StatelessWidget {
  final String id;
  final String text;
  final bool isChecked;
  final Function(String) onTap;
  final Widget? textPrefix;
  const FilterCheckbox(
      {super.key,
      required this.text,
      required this.isChecked,
      required this.onTap,
      required this.id,
      this.textPrefix});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onTap(id),
          child: Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    !isChecked ? UiConstants.kColorBase04 : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(5),
              color: isChecked ? UiConstants.kColorPrimary : Colors.transparent,
            ),
            child: isChecked
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18.0,
                  )
                : null,
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        textPrefix ?? Container(),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: TomasTextButton(
            text: text,
            textStyle: UiConstants.kTextStyleText2,
            foregroundColor: UiConstants.kColorBase04,
            onPressed: () => onTap(id),
          ),
        ),
      ],
    );
  }
}
