import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_text_field_with_text/cubit/tomas_text_field_with_text_cubit.dart';

class TomasTextFieldWithTextTextFieldMobile extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? hintText;
  final TextStyle textStyle;
  final String? label;
  final int? minLines;
  final String? prefixText;
  final String? errorText;
  final RegExp? regExp;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;

  const TomasTextFieldWithTextTextFieldMobile({
    required this.controller,
    this.hintText,
    this.textStyle = UiConstants.kTextStyleText3,
    this.validator,
    this.label,
    this.minLines,
    this.prefixText,
    this.errorText,
    this.regExp,
    super.key,
    this.suffixIcon,
    this.contentPadding = const EdgeInsets.only(top: 16, bottom: 16, left: 16),
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomasTextFieldWithTextCubit,
        TomasTextFieldWithTextState>(
      builder: (context, state) {
        return TextFormField(
            minLines: minLines,
            maxLines: minLines != null ? 50 : null,
            controller: controller,
            decoration: InputDecoration(
              prefixText: prefixText,
              fillColor: UiConstants.kColorBase02,
              filled: true,
              errorText: state.errorText,
              hintText: hintText,
              hintStyle: textStyle.copyWith(color: UiConstants.kColorText03),
              errorStyle: textStyle,
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: UiConstants.kColorError),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              contentPadding: contentPadding,
              enabledBorder: OutlineInputBorder(
                borderSide: state.isNotEmpty && state.isValid
                    ? const BorderSide(
                        width: 1, color: UiConstants.kColorSuccess)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              border: OutlineInputBorder(
                borderSide: state.isNotEmpty && state.isValid
                    ? const BorderSide(
                        width: 1, color: UiConstants.kColorSuccess)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: state.isNotEmpty && state.isValid
                    ? const BorderSide(
                        width: 1, color: UiConstants.kColorSuccess)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              suffixIcon: suffixIcon ??
                  (state.isNotEmpty && state.isValid
                      ? Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: SvgPicture.asset(
                            Paths.checkIconPath,
                            semanticsLabel: 'Icon',
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                                UiConstants.kColorSuccess, BlendMode.modulate),
                          ),
                        )
                      : null),
            ),
            style: textStyle.copyWith(color: UiConstants.kColorText02),
            cursorColor: UiConstants.kColorText02,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) =>
                BlocProvider.of<TomasTextFieldWithTextCubit>(context)
                    .onEditingComplete(controller.text,
                        regExp: regExp, customErrorText: errorText));
      },
    );
  }
}
