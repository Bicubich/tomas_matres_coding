import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomas_matres/ui/features/product_screen/mobile/components/product_image.dart';

class ProductGalleryContent extends StatelessWidget {
  const ProductGalleryContent({Key? key, required this.images})
      : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          itemCount: images.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: ProductImage(
                image: images[index],
                height: 190.w,
                borderRadius: 8,
              ),
            );
          },
        ),
      ),
    );
  }
}
