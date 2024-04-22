import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_text_field_with_text/components/tomas_text_field_with_text_text_field.dart';
import 'package:tomas_matres/ui/components/tomas_text_field_with_text/cubit/tomas_text_field_with_text_cubit.dart';

class TomasTextFieldWithText extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final TextStyle textStyle;
  final String? label;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final int? minLines;
  final int? maxLines;
  final String? prefixText;
  final String? errorText;
  final RegExp? regExp;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final int flex;

  const TomasTextFieldWithText({
    required this.controller,
    this.focusNode,
    this.hintText,
    this.textStyle = UiConstants.kTextStyleText1,
    this.validator,
    super.key,
    this.label,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.minLines,
    this.maxLines,
    this.prefixText,
    this.errorText,
    this.regExp,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding = const EdgeInsets.only(top: 16, bottom: 16, left: 32),
    this.borderRadius = 8,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.flex = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              height: 48,
              child: Text(
                label ?? '',
                style: UiConstants.kTextStyleText4
                    .copyWith(color: UiConstants.kColorBase05),
              ),
            ),
          ),
        BlocProvider(
          create: (context) => TomasTextFieldWithTextCubit(),
          child: TomasTextFieldWithTextTextField(
            controller: controller,
            focusNode: focusNode,
            hintText: hintText,
            textStyle: textStyle,
            label: label,
            minLines: minLines,
            maxLines: maxLines,
            prefixText: prefixText,
            validator: validator,
            regExp: regExp,
            errorText: errorText,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding,
            borderRadius: borderRadius,
            onTap: onTap,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            prefixIcon: prefixIcon,
            flex: flex,
          ),
        )
      ],
    );
  }
}
