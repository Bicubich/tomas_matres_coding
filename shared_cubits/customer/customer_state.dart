part of 'customer_cubit.dart';

sealed class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

final class CustomerLoading extends CustomerState {}

final class CustomerLoaded extends CustomerState {}

final class CustomerError extends CustomerState {}
