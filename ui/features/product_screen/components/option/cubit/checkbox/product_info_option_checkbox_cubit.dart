import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/product_screen/components/option/cubit/error/product_info_option_error_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/price/cubit/product_info_price_cubit.dart';

part 'product_info_option_checkbox_state.dart';

class ProductInfoOptionCheckboxCubit
    extends Cubit<ProductInfoOptionCheckboxState> {
  final ProductInfoOptionErrorCubit productInfoOptionErrorCubit;
  final ProductInfoPriceCubit productInfoPriceCubit;

  ProductInfoOptionCheckboxCubit(
      {required this.productInfoOptionErrorCubit,
      required this.productInfoPriceCubit})
      : super(const ProductInfoOptionCheckboxState(
            selectedOptions: [], countOfOptions: 0));

  final List<String> selected = [];

  void onOptionTap(ProductOptionValue optionValue) {
    if (selected.contains(optionValue.productOptionValueId)) {
      _onOptionDeselection(optionValue.productOptionValueId);
      productInfoPriceCubit.onRemove(
          price: double.parse(optionValue.price).toInt());
    } else {
      _onOptionSelection(optionValue.productOptionValueId);
      productInfoPriceCubit.onAdd(
          price: double.parse(optionValue.price).toInt());
    }

    if (selected.isEmpty) {
      productInfoOptionErrorCubit.show();
    } else {
      productInfoOptionErrorCubit.hide();
    }
  }

  void _onOptionSelection(String optionId) {
    selected.add(optionId);

    emit(ProductInfoOptionCheckboxState(
        selectedOptions: selected, countOfOptions: selected.length));
  }

  void _onOptionDeselection(String optionId) {
    selected.remove(optionId);

    emit(ProductInfoOptionCheckboxState(
        selectedOptions: selected, countOfOptions: selected.length));
  }
}
