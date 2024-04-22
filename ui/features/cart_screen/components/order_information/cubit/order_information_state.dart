part of 'order_information_cubit.dart';

sealed class OrderInformationState extends Equatable {
  const OrderInformationState();

  @override
  List<Object?> get props => [];
}

final class OrderInformationLoading extends OrderInformationState {}

final class OrderInformationLoaded extends OrderInformationState {
  final List<Zone> zones;
  final Customer? customer;

  const OrderInformationLoaded({required this.zones, this.customer});

  @override
  List<Object?> get props => [zones, customer];
}

final class OrderInformationError extends OrderInformationState {}
