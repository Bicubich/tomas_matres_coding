import 'package:equatable/equatable.dart';

abstract class ReceivingMethodEvent extends Equatable {
  const ReceivingMethodEvent();

  @override
  List<Object> get props => [];
}

class SwitchMethodEvent extends ReceivingMethodEvent {
  final bool value;

  const SwitchMethodEvent({required this.value});

  @override
  List<Object> get props => [value];
}
