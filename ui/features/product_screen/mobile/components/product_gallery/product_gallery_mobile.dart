import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';
import 'package:tomas_matres/ui/features/product_screen/mobile/components/product_gallery/cubit/product_gallery_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/mobile/components/product_gallery/cubit/product_gallery_state.dart';
import 'package:tomas_matres/ui/features/product_screen/mobile/components/product_gallery/components/product_gallery_content.dart';

class ProductGalleryMobile extends StatefulWidget {
  const ProductGalleryMobile({super.key, required this.images});

  final List<String> images;

  @override
  State<ProductGalleryMobile> createState() => _ProductGalleryExpandedState();
}

class _ProductGalleryExpandedState extends State<ProductGalleryMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController resultListAnimationController;
  late Animation<double> resultListAnimation;

  @override
  void initState() {
    super.initState();

    resultListAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 250),
    );

    resultListAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: resultListAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    resultListAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductGalleryCubit, ProductGalleryState>(
      listener: (context, state) => onTopGalleryStateChange(context, state),
      builder: (context, state) {
        return SizeTransition(
          sizeFactor: resultListAnimation,
          axis: Axis.horizontal,
          axisAlignment: 1.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(right: 16, top: 16, left: 16),
            color: UiConstants.kColorBase01,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TomasIconButton(
                    onPressed: () =>
                        BlocProvider.of<ProductGalleryCubit>(context)
                            .collapse(),
                    iconPath: Paths.xIconPath,
                    width: 24,
                    height: 24,
                    iconColor: UiConstants.kColorBase05,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ProductGalleryContent(
                  images: widget.images,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void onTopGalleryStateChange(
      BuildContext context, ProductGalleryState state) {
    if (state is ProductGalleryExpandedState) {
      resultListAnimationController.forward();
    }

    if (state is ProductGalleryCollapsedState) {
      resultListAnimationController.reverse();
    }
  }
}
