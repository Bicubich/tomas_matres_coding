import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/features/product_screen/components/product_gallery/cubit/product_gallery_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/product_image.dart';

class ProductGalleryListView extends StatelessWidget {
  const ProductGalleryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductGalleryCubit, ProductGalleryState>(
      builder: (context, state) {
        final PageController pageController = PageController(
            viewportFraction: 1.03,
            initialPage: (state as ProductGalleryInitial).mainImageIndex);
        return Row(
          children: [
            SizedBox(
              width: 180.w,
              height: 680.h,
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(left: 40.w),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: (state).images.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    },
                    child: ProductImage(
                      image: (state).images[index],
                      height: 120.h,
                      width: 180.w,
                      borderRadius: 8.r,
                      opacity: index != state.mainImageIndex ? 0.48 : 1,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 20.h,
                ),
              ),
            ),
            SizedBox(
              width: 200.w,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  int nextImageIndex =
                      (state.mainImageIndex - 1) % state.images.length;
                  (context.read<ProductGalleryCubit>())
                      .changeImage(nextImageIndex);
                  pageController.animateToPage(nextImageIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: UiConstants.kColorBase04,
                  size: 40.w,
                ),
              ),
            ),
            SizedBox(
              width: 50.w,
            ),
            SizedBox(
              height: 680.h,
              width: 1216.w,
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (BuildContext context, int index) =>
                    FractionallySizedBox(
                  widthFactor: 1 / pageController.viewportFraction,
                  child: ProductImage(
                    image: state.images[index],
                  ),
                ),
                itemCount: state.images.length,
                onPageChanged: (value) {
                  (context.read<ProductGalleryCubit>()).changeImage(value);
                },
              ),
            ),
            SizedBox(
              width: 50.w,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  int nextImageIndex =
                      (state.mainImageIndex + 1) % state.images.length;
                  (context.read<ProductGalleryCubit>())
                      .changeImage(nextImageIndex);
                  pageController.animateToPage(nextImageIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: UiConstants.kColorBase04,
                  size: 40.w,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
