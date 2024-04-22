
enum FilterType { price, width, height, length }

class FilterData {
  final FilterType type;
  final FilterDataValues filterDataValues;

  FilterData({required this.type, required this.filterDataValues});

  FilterData copyWith({
    FilterType? type,
    FilterDataValues? filterDataValues,
  }) =>
      FilterData(
        type: type ?? this.type,
        filterDataValues: filterDataValues ?? this.filterDataValues,
      );
}

class FilterDataValues {
  final double minValue;
  final double maxValue;

  FilterDataValues({this.minValue = 0, this.maxValue = 0});

  FilterDataValues copyWith({
    double? minValue,
    double? maxValue,
  }) =>
      FilterDataValues(
          minValue: minValue ?? this.minValue,
          maxValue: maxValue ?? this.maxValue);
}
