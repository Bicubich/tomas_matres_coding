import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_info_option_hover_state.dart';

class ProductInfoOptionHoverCubit extends Cubit<ProductInfoOptionHoverState> {
  ProductInfoOptionHoverCubit() : super(const ProductInfoOptionHoverState());

  void onHover(String hoveredOptionId) {
    emit(ProductInfoOptionHoverState(hoveredOptionId: hoveredOptionId));
  }

  void onHoverExit() {
    emit(const ProductInfoOptionHoverState());
  }
}
