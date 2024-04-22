import 'package:equatable/equatable.dart';

class ProductGalleryState extends Equatable {
  const ProductGalleryState();

  @override
  List<Object> get props => [];
}

final class ProductGalleryCollapsedState extends ProductGalleryState {}

final class ProductGalleryExpandedState extends ProductGalleryState {}
