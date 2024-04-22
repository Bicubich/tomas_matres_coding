import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_text_form_field.dart';
import 'package:tomas_matres/ui/features/catalog/cubit/filter/catalog_filter_cubit.dart';

class TomasRangeWidget extends StatefulWidget {
  const TomasRangeWidget({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.minCurrentValue,
    required this.maxCurrentValue,
    required this.onChanged,
  });

  final double minValue;
  final double maxValue;
  final double minCurrentValue;
  final double maxCurrentValue;
  final Function(double minValue, double maxValue) onChanged;

  @override
  State<TomasRangeWidget> createState() => _TomasRangeWidgetState();
}

class _TomasRangeWidgetState extends State<TomasRangeWidget> {
  late TextEditingController _minValueController;
  late TextEditingController _maxValueController;

  @override
  void initState() {
    _minValueController =
        TextEditingController(text: widget.minCurrentValue.round().toString());
    _maxValueController =
        TextEditingController(text: widget.maxCurrentValue.round().toString());
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _minValueController.text = widget.minCurrentValue.round().toString();
    _maxValueController.text = widget.maxCurrentValue.round().toString();
  }

  @override
  void dispose() {
    _minValueController.dispose();
    _maxValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RangeSlider(
          values: RangeValues(widget.minCurrentValue, widget.maxCurrentValue),
          min: widget.minValue,
          max: widget.maxValue,
          activeColor: UiConstants.kColorPrimary,
          inactiveColor: UiConstants.kColorBase03,
          onChanged: (RangeValues values) {
            _minValueController.text = values.start.round().toString();
            _maxValueController.text = values.end.round().toString();
            widget.onChanged(values.start, values.end);
          },
          labels: RangeLabels(
            widget.maxCurrentValue.round().toString(),
            widget.minCurrentValue.round().toString(),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.kTextFrom.tr().toLowerCase(),
                    style: UiConstants.kTextStyleText3.copyWith(
                      color: UiConstants.kColorText05,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TomasTextFormField(
                      borderRadius: 100,
                      controller: _minValueController,
                      contentPadding:
                          const EdgeInsets.only(top: 14, bottom: 10, left: 12),
                      onChanged: (p0) {
                        return changeSliderPrice(p0, _minValueController);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 2,
                width: 24,
                color: UiConstants.kColorText03),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.kTextTo.tr().toLowerCase(),
                    style: UiConstants.kTextStyleText3.copyWith(
                      color: UiConstants.kColorText05,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TomasTextFormField(
                        borderRadius: 100,
                        controller: _maxValueController,
                        contentPadding: const EdgeInsets.only(
                            top: 14, bottom: 10, left: 12),
                        onChanged: (p0) {
                          return changeSliderPrice(p0, _maxValueController);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  String changeSliderPrice(
      String priceString, TextEditingController textEditingController) {
    try {
      int.parse(priceString);

      double minPrice = double.parse(_minValueController.text);
      double maxPrice = double.parse(_maxValueController.text);

      if (minPrice > maxPrice) {
        textEditingController.text =
            textEditingController == _minValueController
                ? _maxValueController.text
                : _minValueController.text;
        textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: textEditingController.text.length));
      }

      context.read<CatalogFilterCubit>().updateValue(
          minValue: double.parse(_minValueController.text),
          maxValue: double.parse(_maxValueController.text));

      return textEditingController.text;
    } catch (_) {
      textEditingController.text = textEditingController == _maxValueController
          ? widget.maxValue.round().toString()
          : widget.minValue.round().toString();
    }
    return textEditingController.text;
  }
}
