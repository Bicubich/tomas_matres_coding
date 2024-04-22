part of 'receiving_method_bloc.dart';

class ReceivingMethodState extends Equatable {
  final bool isDelivery;

  const ReceivingMethodState({required this.isDelivery});

  @override
  List<Object> get props => [isDelivery];

  ReceivingMethodState copyWith({bool? isDelivery}) {
    return ReceivingMethodState(
      isDelivery: isDelivery ?? this.isDelivery,
    );
  }
}
