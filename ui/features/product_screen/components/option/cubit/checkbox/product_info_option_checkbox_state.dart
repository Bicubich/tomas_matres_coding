part of 'product_info_option_checkbox_cubit.dart';

class ProductInfoOptionCheckboxState extends Equatable {
  final List<String> selectedOptions;
  final int countOfOptions;

  const ProductInfoOptionCheckboxState(
      {required this.selectedOptions, required this.countOfOptions});

  @override
  List<Object> get props => [selectedOptions, countOfOptions];
}
