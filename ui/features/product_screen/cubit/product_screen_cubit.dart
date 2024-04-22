import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/api/api.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';

part 'product_screen_state.dart';

class ProductScreenCubit extends Cubit<ProductScreenState> {
  final String? productId;
  Product? product;
  ProductScreenCubit({required this.productId, this.product})
      : super(ProductScreenLoading()) {
    _init();
  }

  Future<void> _init() async {
    if (product != null) {
      emit(ProductScreenLoaded(product: product!));
    } else {
      if (productId != null) {
        product = await TomasApi.getProduct(productId!);

        if (product != null) {
          emit(ProductScreenLoaded(product: product!));
        } else {
          emit(ProductScreenErrorNotFound());
        }
      } else {
        emit(ProductScreenError());
      }
    }
  }
}
