import 'package:equatable/equatable.dart';

class DropdownTextState extends Equatable {
  final bool isDropdownVisible;

  const DropdownTextState({required this.isDropdownVisible});

  @override
  List<Object> get props => [isDropdownVisible];
}
