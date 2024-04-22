part of 'it_may_suit_cubit.dart';

sealed class ItMaySuitState extends Equatable {
  const ItMaySuitState();

  @override
  List<Object> get props => [];
}

final class ItMaySuitLoading extends ItMaySuitState {}

final class ItMaySuitLoaded extends ItMaySuitState {
  final List<Product> itMaySuitProducts;
  final int countOfProducts;

  const ItMaySuitLoaded(
      {required this.itMaySuitProducts, required this.countOfProducts});

  @override
  List<Object> get props => [
        itMaySuitProducts,
        countOfProducts,
      ];
}

final class ItMaySuitNoData extends ItMaySuitState {}
