part of 'product_gallery_cubit.dart';

abstract class ProductGalleryState extends Equatable {}

class ProductGalleryInitial extends ProductGalleryState {
  final List<String> images;
  final int mainImageIndex;

  ProductGalleryInitial({
    required this.images,
    required this.mainImageIndex,
  });

  ProductGalleryInitial copyWith({
    List<String>? images,
    int? mainImageIndex,
  }) {
    return ProductGalleryInitial(
      images: images ?? this.images,
      mainImageIndex: mainImageIndex ?? this.mainImageIndex,
    );
  }

  @override
  List<Object> get props => [
        images,
        mainImageIndex,
      ];
}
