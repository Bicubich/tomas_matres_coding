import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/api/constants.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';
import 'package:tomas_matres/ui/components/tomas_icon_with_text_button.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cart_item/cart_item_options.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/quantity/cart_view_quantity_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/cart_product_model.dart';

class CartItem extends StatelessWidget {
  final CartProduct cartProduct;
  const CartItem({required this.cartProduct, super.key});

  @override
  Widget build(BuildContext context) {
    if (cartProduct.product != null) {
      final Product product = cartProduct.product!;

      return Container(
        constraints: const BoxConstraints(
          minHeight: 180,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => NavigationHelper.openInNewTab(
                    '${Routes.productScreen.path}&id=${cartProduct.productId}'),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 280,
                      height: 160,
                      color: UiConstants.kColorBase02,
                      child: CachedNetworkImage(
                        imageUrl: '${ApiConstants.imageUrl}${product.image}',
                        width: 280,
                        height: 160,
                        fit: BoxFit.fitHeight,
                        color: UiConstants.kColorBase02,
                        colorBlendMode: BlendMode.modulate,
                        errorWidget: (context, url, error) {
                          return Container(
                            color: UiConstants.kColorBase04,
                          );
                        },
                      ),
                    )),
              ),
            ),
            const SizedBox(
              width: 40.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => NavigationHelper.openInNewTab(
                                '${Routes.productScreen.path}&id=${cartProduct.productId}'),
                            child: Text(
                              product.name,
                              maxLines: 2,
                              style: UiConstants.kTextStyleText2
                                  .copyWith(color: UiConstants.kColorBase05),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      TomasIconWithTextButton(
                        onPressed: () => BlocProvider.of<CartCubit>(context)
                            .removeFromCart(cartProduct),
                        iconPath: Paths.deleteIconPath,
                        text: LocaleKeys.kTextDelete.tr(),
                        textStyle: UiConstants.kTextStyleText2
                            .copyWith(color: UiConstants.kColorBase05),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  if (cartProduct.selectedOptionsIds.isNotEmpty)
                    CartItemOptions(
                      cartProduct: cartProduct,
                    ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 44,
                        width: 116,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: UiConstants.kColorBase03),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          child: BlocBuilder<CartViewQuantityCubit,
                              CartViewQuantityState>(
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TomasIconButton(
                                      onPressed: () => BlocProvider.of<
                                              CartViewQuantityCubit>(context)
                                          .decrease(),
                                      iconPath: Paths.minusIconPath),
                                  Text(
                                    state.itemCount.toString(),
                                    style: UiConstants.kTextStyleText3.copyWith(
                                        color: UiConstants.kColorBase05,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  TomasIconButton(
                                      onPressed: () => BlocProvider.of<
                                              CartViewQuantityCubit>(context)
                                          .increase(),
                                      iconPath: Paths.plusIconPath),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${product.specialPrice ?? product.price} ₽",
                              style: UiConstants.kTextStylePriceSemiBold1
                                  .copyWith(color: UiConstants.kColorText01)),
                          const SizedBox(
                            width: 24,
                          ),
                          product.specialPrice != null
                              ? RichText(
                                  text: TextSpan(
                                    text: "${product.price} ₽",
                                    style: UiConstants.kTextStylePriceRegular1
                                        .copyWith(
                                      color: UiConstants.kColorText05,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: UiConstants.kColorText05,
                                      decorationThickness: 2.0,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
