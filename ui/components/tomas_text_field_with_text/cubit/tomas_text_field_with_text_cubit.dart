import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';

part 'tomas_text_field_with_text_state.dart';

class TomasTextFieldWithTextCubit extends Cubit<TomasTextFieldWithTextState> {
  TomasTextFieldWithTextCubit()
      : super(const TomasTextFieldWithTextState(
            isValid: true, isNotEmpty: false));

  void onEditingComplete(String value,
      {RegExp? regExp, String? customErrorText}) {
    bool isValid = true;
    bool isNotEmpty = false;
    String? errorText;

    if (value.isEmpty) {
      isValid = false;
      errorText = LocaleKeys.kTextRequiredField.tr();
    } else {
      isNotEmpty = true;
      if (regExp != null) {
        isValid = regExp.hasMatch(value);
        if (!isValid) {
          errorText = customErrorText ?? '';
        }
      }
    }

    emit(TomasTextFieldWithTextState(
        isValid: isValid, isNotEmpty: isNotEmpty, errorText: errorText));
  }
}
