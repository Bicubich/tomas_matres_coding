import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_text_field_with_text/components/mobile/tomas_text_field_with_text_text_field_mobile.dart';
import 'package:tomas_matres/ui/components/tomas_text_field_with_text/cubit/tomas_text_field_with_text_cubit.dart';

class TomasTextFieldWithTextMobile extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? hintText;
  final TextStyle textStyle;
  final String? label;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final int? minLines;
  final String? prefixText;
  final String? errorText;
  final RegExp? regExp;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;

  const TomasTextFieldWithTextMobile({
    required this.controller,
    this.hintText,
    this.textStyle = UiConstants.kTextStyleText3,
    this.validator,
    super.key,
    this.label,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.minLines,
    this.prefixText,
    this.errorText,
    this.regExp,
    this.suffixIcon,
    this.contentPadding = const EdgeInsets.only(top: 16, bottom: 16, left: 16),
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label ?? '',
            style: UiConstants.kTextStyleText4
                .copyWith(color: UiConstants.kColorBase05),
          ),
        const SizedBox(
          height: 16,
        ),
        BlocProvider(
          create: (context) => TomasTextFieldWithTextCubit(),
          child: TomasTextFieldWithTextTextFieldMobile(
            controller: controller,
            hintText: hintText,
            textStyle: textStyle,
            label: label,
            minLines: minLines,
            prefixText: prefixText,
            validator: validator,
            regExp: regExp,
            errorText: errorText,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding,
            borderRadius: borderRadius,
          ),
        )
      ],
    );
  }
}
