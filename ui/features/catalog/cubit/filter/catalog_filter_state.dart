part of 'catalog_filter_cubit.dart';

sealed class CatalogFilterState extends Equatable {
  const CatalogFilterState();

  @override
  List<Object> get props => [];
}

final class CatalogFilterInitial extends CatalogFilterState {}

final class CatalogFilterLoaded extends CatalogFilterState {
  final double minValue;
  final double maxValue;
  final double minCurrentValue;
  final double maxCurrentValue;

  const CatalogFilterLoaded(
      {required this.minValue,
      required this.maxValue,
      required this.minCurrentValue,
      required this.maxCurrentValue});

  CatalogFilterLoaded copyWith(
          {double? minValue,
          double? maxValue,
          double? minCurrentValue,
          double? maxCurrentValue}) =>
      CatalogFilterLoaded(
          minValue: minValue ?? this.minValue,
          maxValue: maxValue ?? this.maxValue,
          minCurrentValue: minCurrentValue ?? this.minCurrentValue,
          maxCurrentValue: maxCurrentValue ?? this.maxCurrentValue);

  @override
  List<Object> get props =>
      [minValue, maxValue, minCurrentValue, maxCurrentValue];
}

final class CatalogFilterNoProducts extends CatalogFilterState {}
