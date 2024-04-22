import 'package:equatable/equatable.dart';

class TotalPriceState extends Equatable {
  final bool isDropdownVisible;

  const TotalPriceState({required this.isDropdownVisible});

  @override
  List<Object> get props => [isDropdownVisible];
}
