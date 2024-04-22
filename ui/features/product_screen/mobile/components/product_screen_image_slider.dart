import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomas_matres/ui/components/mobile/mobile_page_indicator.dart';
import 'package:tomas_matres/ui/features/product_screen/mobile/components/product_image.dart';

class ProductScreenImageSlider extends StatefulWidget {
  final List<String> images;
  final Function() onTapImage;

  const ProductScreenImageSlider(
      {required this.images, super.key, required this.onTapImage});

  @override
  State<ProductScreenImageSlider> createState() =>
      _ProductScreenImageSliderState();
}

class _ProductScreenImageSliderState extends State<ProductScreenImageSlider> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 224.w,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () => widget.onTapImage(),
                    child: ProductImage(
                      image: widget.images[index],
                      height: 190.w,
                      borderRadius: 8,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
              visible: widget.images.length > 1,
              child: MobilePageIndicator(
                controller: pageController,
                pageCount: widget.images.length,
              )),
        ],
      ),
    );
  }
}
