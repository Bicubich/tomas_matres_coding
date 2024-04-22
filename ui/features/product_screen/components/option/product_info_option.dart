import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/product_screen/components/option/cubit/checkbox/product_info_option_checkbox_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/option/cubit/error/product_info_option_error_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/option/cubit/hover/product_info_option_hover_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/option/cubit/radio/product_info_option_radio_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/price/cubit/product_info_price_cubit.dart';

class ProductInfoOption extends StatelessWidget {
  final Option option;
  final Function(String optionId) onRadioOptionSelection;
  final Function(List<String> optionIds) onCheckboxOptionsChange;

  const ProductInfoOption(
      {required this.option,
      required this.onRadioOptionSelection,
      required this.onCheckboxOptionsChange,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductInfoOptionHoverCubit,
        ProductInfoOptionHoverState>(
      builder: (context, hoverState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
                text: TextSpan(
                    text: option.name,
                    style: UiConstants.kTextStyleHeadline4.copyWith(
                      color: UiConstants.kColorText02,
                    ),
                    children: [
                  if (option.required == "1")
                    TextSpan(
                        text: '*',
                        style: UiConstants.kTextStyleHeadline4.copyWith(
                          color: UiConstants.kColorError,
                        ))
                ])),
            const SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children:
                  List.generate(option.productOptionValue.length, (index) {
                ProductOptionValue optionValue =
                    option.productOptionValue[index];
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (event) =>
                      BlocProvider.of<ProductInfoOptionHoverCubit>(context)
                          .onHover(optionValue.productOptionValueId),
                  onExit: (event) =>
                      BlocProvider.of<ProductInfoOptionHoverCubit>(context)
                          .onHoverExit(),
                  child: GestureDetector(
                    onTap: () => onOptionSelection(context, optionValue),
                    child: Row(
                      children: [
                        if (option.type == 'radio')
                          BlocBuilder<ProductInfoOptionRadioCubit,
                              ProductInfoOptionRadioState>(
                            builder: (context, radioState) {
                              return Radio<ProductOptionValue>(
                                  value: optionValue,
                                  groupValue: radioState.selectedOptionValue,
                                  splashRadius: 0,
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    if (optionValue.productOptionValueId ==
                                        hoverState.hoveredOptionId) {
                                      return UiConstants.kColorPrimary;
                                    }
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return UiConstants.kColorPrimary;
                                    }
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return UiConstants.kColorLink;
                                    }
                                    return UiConstants.kColorBase04;
                                  }),
                                  onChanged: (value) =>
                                      onOptionSelection(context, optionValue));
                            },
                          ),
                        if (option.type == 'checkbox')
                          BlocBuilder<ProductInfoOptionCheckboxCubit,
                              ProductInfoOptionCheckboxState>(
                            builder: (context, checkboxState) {
                              return Checkbox(
                                value: checkboxState.selectedOptions
                                    .contains(optionValue.productOptionValueId),
                                onChanged: (value) =>
                                    onOptionSelection(context, optionValue),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                splashRadius: 0,
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (optionValue.productOptionValueId ==
                                      hoverState.hoveredOptionId) {
                                    return UiConstants.kColorPrimary;
                                  }
                                  if (states.contains(MaterialState.hovered)) {
                                    return UiConstants.kColorPrimary;
                                  }
                                  if (states.contains(MaterialState.selected)) {
                                    return UiConstants.kColorLink;
                                  }
                                  return UiConstants.kColorBase04;
                                }),
                              );
                            },
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(optionValue.name,
                              overflow: TextOverflow.ellipsis,
                              style: UiConstants.kTextStyleText1.copyWith(
                                color: UiConstants.kColorText02,
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${optionValue.pricePrefix} ${optionValue.price.split('.').first}₽",
                          style: UiConstants.kTextStyleText1.copyWith(
                            color: UiConstants.kColorText03,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
            BlocBuilder<ProductInfoOptionErrorCubit,
                ProductInfoOptionErrorState>(
              builder: (context, state) {
                if (state is ProductInfoOptionErrorHidden) {
                  return Container();
                }
                return Container(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(errorText(),
                        style: UiConstants.kTextStyleText3.copyWith(
                          color: UiConstants.kColorError,
                        )));
              },
            ),
          ],
        );
      },
    );
  }

  void onOptionSelection(BuildContext context, ProductOptionValue optionValue) {
    if (option.type == 'radio') {
      ProductInfoOptionRadioState radioState =
          BlocProvider.of<ProductInfoOptionRadioCubit>(context).state;

      if (radioState.selectedOptionValue != null) {
        BlocProvider.of<ProductInfoPriceCubit>(context).onRemove(
            price: radioState.selectedOptionValue != null
                ? double.parse(radioState.selectedOptionValue!.price).ceil()
                : 0);
      }

      BlocProvider.of<ProductInfoPriceCubit>(context)
          .onAdd(price: double.parse(optionValue.price).ceil());

      BlocProvider.of<ProductInfoOptionRadioCubit>(context)
          .onOptionSelect(selectedOptionValue: optionValue);
      onRadioOptionSelection(optionValue.productOptionValueId);
    }
    if (option.type == 'checkbox') {
      BlocProvider.of<ProductInfoOptionCheckboxCubit>(context)
          .onOptionTap(optionValue);
      onCheckboxOptionsChange(
          BlocProvider.of<ProductInfoOptionCheckboxCubit>(context).selected);
    }
  }

  String errorText() {
    if (option.type == 'checkbox') {
      return LocaleKeys.kTextRequiredCheckbox.tr();
    }
    if (option.type == 'radio') {
      return LocaleKeys.kTextRequiredRadio.tr();
    }

    return LocaleKeys.kTextRequiredField.tr();
  }
}
