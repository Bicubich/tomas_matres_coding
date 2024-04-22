import 'package:equatable/equatable.dart';

class CustomFilter extends Equatable {
  final String id;
  final String name;

  const CustomFilter({required this.id, required this.name});

  @override
  List<Object> get props => [
        id,
        name,
      ];
}

class CustomFilterGroup extends Equatable {
  final String id;
  final String name;
  final List<CustomFilter> filters;

  const CustomFilterGroup(
      {required this.id, required this.name, required this.filters});

  @override
  List<Object> get props => [
        id,
        name,
        filters,
      ];
}
