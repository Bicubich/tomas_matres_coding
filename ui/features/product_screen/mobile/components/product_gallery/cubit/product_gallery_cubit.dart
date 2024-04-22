import 'package:bloc/bloc.dart';
import 'package:tomas_matres/ui/features/product_screen/mobile/components/product_gallery/cubit/product_gallery_state.dart';

class ProductGalleryCubit extends Cubit<ProductGalleryState> {
  ProductGalleryCubit() : super(ProductGalleryCollapsedState());

  Future expand() async {
    emit(ProductGalleryExpandedState());
  }

  void collapse() {
    emit(ProductGalleryCollapsedState());
  }
}
