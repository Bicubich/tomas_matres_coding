part of 'product_info_option_radio_cubit.dart';

class ProductInfoOptionRadioState extends Equatable {
  final ProductOptionValue? selectedOptionValue;

  const ProductInfoOptionRadioState({this.selectedOptionValue});

  @override
  List<Object?> get props => [selectedOptionValue];
}
