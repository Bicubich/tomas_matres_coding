import 'package:equatable/equatable.dart';

class TomasDropdownMenuWithTextData extends Equatable {
  final String id;
  final String title;

  const TomasDropdownMenuWithTextData({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}
