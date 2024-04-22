import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/api/constants.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_icon_with_text_button.dart';
import 'package:tomas_matres/ui/components/tomas_outlined_button.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/cubit/card_animation/it_may_suit_card_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/cart_product_model.dart';

class ItMaySuitCard extends StatelessWidget {
  final Product product;
  final Animation<double> visibilityAnimation;
  final Animation<double> imageWidthAnimation;
  final Animation<double> imageHeightAnimation;
  final Animation<double> contentHeightAnimation;

  const ItMaySuitCard(
      {required this.product,
      required this.visibilityAnimation,
      required this.imageWidthAnimation,
      required this.imageHeightAnimation,
      required this.contentHeightAnimation,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      onTap: () => NavigationHelper.openInNewTab(
          '${Routes.productScreen.path}&id=${product.id}'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
              animation:
                  Listenable.merge([imageWidthAnimation, imageHeightAnimation]),
              builder: (context, child) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      color: UiConstants.kColorBase02,
                      child: CachedNetworkImage(
                        imageUrl: '${ApiConstants.imageUrl}${product.image}',
                        width: imageWidthAnimation.value,
                        height: imageHeightAnimation.value,
                        fit: BoxFit.fitHeight,
                        color: UiConstants.kColorBase02,
                        colorBlendMode: BlendMode.modulate,
                        errorWidget: (context, url, error) {
                          return Container(
                            color: UiConstants.kColorBase04,
                          );
                        },
                      ),
                    ));
              }),
          AnimatedBuilder(
              animation: Listenable.merge(
                  [contentHeightAnimation, imageWidthAnimation]),
              builder: (context, child) {
                return SizedBox(
                  height: contentHeightAnimation.value,
                  width: imageWidthAnimation.value,
                  child: BlocBuilder<ItMaySuitCardCubit, ItMaySuitCardState>(
                    builder: (context, state) {
                      if (state is ItMaySuitCardVisible) {
                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FadeTransition(
                                opacity: visibilityAnimation,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text('${product.name}\n',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: UiConstants.kTextStyleText5
                                          .copyWith(
                                              color: UiConstants.kColorText03)),
                                ),
                              ),
                              FadeTransition(
                                opacity: visibilityAnimation,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          "${product.specialPrice ?? product.price} ₽",
                                          style: UiConstants
                                              .kTextStylePriceSemiBold1
                                              .copyWith(
                                                  color: UiConstants
                                                      .kColorText01)),
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      product.specialPrice != null
                                          ? RichText(
                                              text: TextSpan(
                                                text: "${product.price} ₽",
                                                style: UiConstants
                                                    .kTextStylePriceRegular1
                                                    .copyWith(
                                                  color:
                                                      UiConstants.kColorText05,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor:
                                                      UiConstants.kColorText05,
                                                  decorationThickness: 2.0,
                                                  decorationStyle:
                                                      TextDecorationStyle.solid,
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                              FadeTransition(
                                  opacity: visibilityAnimation,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: AnimatedBuilder(
                                        animation: imageWidthAnimation,
                                        builder: (context, child) {
                                          return SizedBox(
                                            width: imageWidthAnimation.value,
                                            child: BlocBuilder<CartCubit,
                                                CartState>(
                                              builder: (context, state) {
                                                bool isInCart = false;
                                                if (state is CartLoaded) {
                                                  if (state.cartProducts
                                                      .isNotEmpty) {
                                                    int cartProductIndex = state
                                                        .cartProducts
                                                        .indexWhere((element) =>
                                                            element.productId ==
                                                            product.id);

                                                    if (cartProductIndex !=
                                                        -1) {
                                                      isInCart = true;
                                                    }
                                                  }
                                                }
                                                if (isInCart) {
                                                  return TomasIconWithTextButton(
                                                    onPressed: () =>
                                                        onTapDeleteItemCart(
                                                            context, product),
                                                    iconPath:
                                                        Paths.checkIconPath,
                                                    text: LocaleKeys
                                                        .kTextAddedToCart
                                                        .tr(),
                                                    textStyle: UiConstants
                                                        .kTextStyleText1,
                                                    textColor: UiConstants
                                                        .kColorPrimary,
                                                    iconColor: UiConstants
                                                        .kColorPrimary,
                                                  );
                                                } else {
                                                  return TomasOutlinedButton(
                                                      onPressed: () =>
                                                          onTapAddCart(
                                                              context, product),
                                                      text: LocaleKeys.kTextAdd
                                                          .tr());
                                                }
                                              },
                                            ),
                                          );
                                        }),
                                  ))
                            ]);
                      } else {
                        return Container();
                      }
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }

  onTapAddCart(BuildContext context, Product product) {
    bool isNeedSelectOption = false;
    if (product.options.isNotEmpty) {
      for (Option option in product.options) {
        if (option.required == '1') {
          isNeedSelectOption = true;
          navigateToProduct(context, product);
          break;
        }
      }
    }
    if (!isNeedSelectOption) {
      BlocProvider.of<CartCubit>(context).addToCart(
        product,
      );
    }
  }

  onTapDeleteItemCart(BuildContext context, Product product) {
    CartProduct? cartProduct = BlocProvider.of<CartCubit>(context)
        .cartProducts
        .firstWhereOrNull((element) => element.productId == product.id);
    if (cartProduct != null) {
      BlocProvider.of<CartCubit>(context).removeFromCart(
        cartProduct,
      );
    }
  }

  void navigateToProduct(BuildContext context, Product product) {
    var route = CustomRoute(
        title: Routes.productScreen.title,
        path: '${Routes.productScreen.path}&id=${product.id}');
    NavigationHelper.replaceRoute(context, route);
  }
}
