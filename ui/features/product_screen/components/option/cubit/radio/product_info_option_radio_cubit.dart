import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/product_screen/components/option/cubit/error/product_info_option_error_cubit.dart';

part 'product_info_option_radio_state.dart';

class ProductInfoOptionRadioCubit extends Cubit<ProductInfoOptionRadioState> {
  final ProductInfoOptionErrorCubit productInfoOptionErrorCubit;

  ProductInfoOptionRadioCubit({required this.productInfoOptionErrorCubit})
      : super(const ProductInfoOptionRadioState());

  ProductOptionValue? selected;

  void onOptionSelect({ProductOptionValue? selectedOptionValue}) {
    if (selectedOptionValue != null) {
      selected = selectedOptionValue;
    }
    if (selected != null) {
      productInfoOptionErrorCubit.hide();
    }
    emit(ProductInfoOptionRadioState(selectedOptionValue: selected));
  }
}
