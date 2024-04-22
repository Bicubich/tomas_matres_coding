import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_dropdown_menu_with_text/data/tomas_dropdown_menu_with_text_data_model.dart';

class TomasDropdownMenuWithTextMobile extends StatefulWidget {
  final Function(TomasDropdownMenuWithTextData) onChanged;
  final String label;
  final TomasDropdownMenuWithTextData? initValue;
  final bool isActiveFirstElement;
  final List<TomasDropdownMenuWithTextData> data;
  final String? Function(TomasDropdownMenuWithTextData?)? validator;

  const TomasDropdownMenuWithTextMobile(
      {required this.onChanged,
      required this.label,
      required this.data,
      required this.validator,
      this.isActiveFirstElement = true,
      super.key,
      this.initValue});

  @override
  State<TomasDropdownMenuWithTextMobile> createState() =>
      _TomasDropdownMenuWithTextMobileState();
}

class _TomasDropdownMenuWithTextMobileState
    extends State<TomasDropdownMenuWithTextMobile> {
  late TomasDropdownMenuWithTextData currentValue;
  List<TomasDropdownMenuWithTextData> filteredOptions = [];

  @override
  void initState() {
    currentValue = widget.initValue ?? widget.data.first;
    super.initState();
    filteredOptions.addAll(widget.data);
  }

  void filterOptions(String query) {
    filteredOptions.clear();
    if (query.isEmpty) {
      filteredOptions.addAll(widget.data);
    } else {
      filteredOptions.addAll(widget.data.where(
          (item) => item.title.toLowerCase().startsWith(query.toLowerCase())));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: UiConstants.kTextStyleText4
              .copyWith(color: UiConstants.kColorBase05),
        ),
        const SizedBox(
          height: 16,
        ),
        DropdownButtonFormField<TomasDropdownMenuWithTextData>(
            value: currentValue,
            menuMaxHeight: 400,
            icon: const Icon(null),
            borderRadius: BorderRadius.circular(8),
            decoration: InputDecoration(
              fillColor: UiConstants.kColorBase02,
              filled: true,
              errorStyle: UiConstants.kTextStyleText5,
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: UiConstants.kColorError),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.only(top: 16, bottom: 16, left: 16),
              enabledBorder: OutlineInputBorder(
                borderSide: currentValue.id != '0'
                    ? const BorderSide(
                        width: 1, color: UiConstants.kColorSuccess)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: currentValue.id != '0'
                    ? const BorderSide(
                        width: 1, color: UiConstants.kColorSuccess)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: currentValue.id != '0'
                    ? const BorderSide(
                        width: 1, color: UiConstants.kColorSuccess)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            style: UiConstants.kTextStyleText3
                .copyWith(color: UiConstants.kColorText03),
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            items: List.generate(filteredOptions.length, (index) {
              return DropdownMenuItem(
                value: widget.data[index],
                enabled: !widget.isActiveFirstElement ? !(index == 0) : true,
                child: Text(
                  widget.data[index].title,
                  style: !widget.isActiveFirstElement && index == 0
                      ? null
                      : UiConstants.kTextStyleText3
                          .copyWith(color: UiConstants.kColorText02),
                ),
              );
            }),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  currentValue = value;
                });
                widget.onChanged(value);
              }
            }),
      ],
    );
  }
}
