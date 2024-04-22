import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class TomasTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String)? onChanged;
  final double borderRadius;
  final EdgeInsets contentPadding;

  const TomasTextFormField({
    required this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.borderRadius = 8,
    this.contentPadding = const EdgeInsets.only(top: 16, bottom: 16, left: 32),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          fillColor: UiConstants.kColorBase02,
          filled: true,
          hintText: hintText,
          hintStyle: UiConstants.kTextStyleText3
              .copyWith(color: UiConstants.kColorText03),
          errorStyle: UiConstants.kTextStyleText5,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(
                borderRadius), // Указываем радиус закругления
          ),
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(
                borderRadius), // Указываем радиус закругления
          )),
      style:
          UiConstants.kTextStyleText3.copyWith(color: UiConstants.kColorText02),
      cursorColor: UiConstants.kColorText02,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
