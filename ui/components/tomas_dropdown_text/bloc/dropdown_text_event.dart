import 'package:equatable/equatable.dart';

abstract class DropdownTextEvent extends Equatable {
  const DropdownTextEvent();

  @override
  List<Object> get props => [];
}

class ToggleDropdownEvent extends DropdownTextEvent {}
