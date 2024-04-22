import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/api/constants.dart';
import 'package:tomas_matres/constants/ui_constants.dart';

class ProductImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final double borderRadius;
  final double opacity;
  const ProductImage({
    required this.image,
    super.key,
    this.height,
    this.width,
    this.borderRadius = 24,
    this.opacity = 1,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: '${ApiConstants.imageUrl}$image',
        height: height,
        width: width,
        fit: BoxFit.cover,
        color: UiConstants.kColorBase02.withOpacity(opacity),
        colorBlendMode: BlendMode.modulate,
        errorWidget: (context, url, error) {
          return Container(
            color: UiConstants.kColorBase04,
          );
        },
      ),
    );
  }
}
