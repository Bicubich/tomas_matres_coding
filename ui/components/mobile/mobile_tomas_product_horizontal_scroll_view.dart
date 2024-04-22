import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/ui/components/mobile/mobile_product_list_card.dart';
import 'package:tomas_matres/ui/components/mobile/mobile_tomas_outlined_button.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/favorite_icon/favorite_icon_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/top_menu_favorite/top_menu_favorite_cubit.dart';

class MobileTomasProductHorizontalScrollView extends StatefulWidget {
  final String title;
  final double height;
  final List<Product> products;
  final String? buttonText;
  final VoidCallback? onButtonPress;
  final bool isTitleCenter;

  const MobileTomasProductHorizontalScrollView(
      {required this.title,
      required this.products,
      this.buttonText,
      this.onButtonPress,
      super.key,
      this.isTitleCenter = true,
      this.height = 454});

  @override
  State<MobileTomasProductHorizontalScrollView> createState() =>
      _MobileTomasProductHorizontalScrollViewState();
}

class _MobileTomasProductHorizontalScrollViewState
    extends State<MobileTomasProductHorizontalScrollView> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        crossAxisAlignment: widget.isTitleCenter
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: widget.isTitleCenter ? 0 : 16),
            child: Text(
              widget.title,
              style: UiConstants.kTextStyleHeadline5
                  .copyWith(color: UiConstants.kColorText01),
              textAlign:
                  widget.isTitleCenter ? TextAlign.center : TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            height: 286,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: RawScrollbar(
                thickness: 2,
                thumbColor: UiConstants.kColorSecondary,
                trackColor: Colors.transparent,
                controller: scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                crossAxisMargin: 15,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                trackBorderColor: Colors.transparent,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.products.length,
                    padding: const EdgeInsets.only(left: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return BlocProvider(
                        create: (context) => FavoriteIconCubit(
                            productId: widget.products[index].id,
                            topMenuFavoriteCubit:
                                BlocProvider.of<TopMenuFavoriteCubit>(context)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Listener(
                              onPointerDown: (event) => Utils.onPointerDown(
                                  context,
                                  event,
                                  '${Routes.productScreen.path}&id=${widget.products[index].id}'),
                              child: GestureDetector(
                                onTap: () => navigateToProduct(
                                  context,
                                  product: widget.products[index],
                                ),
                                onLongPressStart: (details) => Utils.onLongPress(
                                    context,
                                    details,
                                    '${Routes.productScreen.path}&id=${widget.products[index].id}'),
                                child: MobileProductsListCard(
                                    product: widget.products[index]),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          if (widget.buttonText != null)
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  MobileTomasOutlinedButton(
                    onPressed: () => widget.onButtonPress != null
                        ? widget.onButtonPress!()
                        : null,
                    text: widget.buttonText ?? '',
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  void navigateToProduct(BuildContext context, {required Product product}) {
    NavigationHelper.addRoute(
        context,
        CustomRoute(
            title: product.name,
            path: '${Routes.productScreen.path}&id=${product.id}'));
  }
}
