import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_info_option_error_state.dart';

class ProductInfoOptionErrorCubit extends Cubit<ProductInfoOptionErrorState> {
  final bool required;

  ProductInfoOptionErrorCubit({required this.required})
      : super(ProductInfoOptionErrorHidden()) {
    _init();
  }

  void _init() {
    if (required) {
      emit(ProductInfoOptionErrorShown());
    }
  }

  void show() {
    emit(ProductInfoOptionErrorShown());
  }

  void hide() {
    emit(ProductInfoOptionErrorHidden());
  }
}
