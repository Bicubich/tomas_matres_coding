import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';
import 'package:tomas_matres/ui/features/product_screen/components/product_gallery/product_gallery_list_view.dart';

class ProductGallery extends StatelessWidget {
  const ProductGallery({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      insetPadding: EdgeInsets.only(left: 40.w, right: 40.w),
      child: Container(
        height: 900.h,
        decoration: BoxDecoration(
          color: UiConstants.kColorBase01,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Positioned(
              top: 40,
              right: 40,
              child: TomasIconButton(
                onPressed: () => Navigator.pop(context),
                iconPath: Paths.xIconPath,
                width: 24.w,
                height: 24.w,
                iconColor: UiConstants.kColorBase05,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40).h,
              child: const ProductGalleryListView(),
            )
          ],
        ),
      ),
    );
  }
}
