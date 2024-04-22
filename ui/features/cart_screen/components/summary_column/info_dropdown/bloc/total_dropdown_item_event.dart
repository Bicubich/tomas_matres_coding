import 'package:equatable/equatable.dart';

abstract class TotalPriceEvent extends Equatable {
  const TotalPriceEvent();

  @override
  List<Object> get props => [];
}

class ToggleDropdownEvent extends TotalPriceEvent {}
