part of 'tomas_text_field_with_text_cubit.dart';

class TomasTextFieldWithTextState extends Equatable {
  final bool isValid;
  final bool isNotEmpty;
  final String? errorText;

  const TomasTextFieldWithTextState(
      {required this.isValid, required this.isNotEmpty, this.errorText});

  @override
  List<Object?> get props => [isValid, errorText];
}
