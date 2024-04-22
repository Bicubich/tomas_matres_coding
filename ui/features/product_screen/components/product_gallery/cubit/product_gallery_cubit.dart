import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_gallery_state.dart';

class ProductGalleryCubit extends Cubit<ProductGalleryState> {
  ProductGalleryCubit({required List<String> images, int? mainImageIndex})
      : super(ProductGalleryInitial(
            images: images, mainImageIndex: mainImageIndex ?? 0));

  changeImage(index) {
    emit((state as ProductGalleryInitial).copyWith(
      mainImageIndex: index,
    ));
  }
}
