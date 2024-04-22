import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomas_matres/api/constants.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/quantity/cart_view_quantity_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/cart_product_model.dart';
import 'package:tomas_matres/ui/features/cart_screen/mobile/components/cart_view/cart_item/cart_item_options.dart';

class CartItem extends StatelessWidget {
  final CartProduct cartProduct;
  const CartItem({required this.cartProduct, super.key});

  @override
  Widget build(BuildContext context) {
    if (cartProduct.product != null) {
      final Product product = cartProduct.product!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => onTapProduct(context, product),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 150.w,
                          constraints: const BoxConstraints(maxHeight: 350),
                          color: UiConstants.kColorBase02,
                          child: CachedNetworkImage(
                            imageUrl:
                                '${ApiConstants.imageUrl}${product.image}',
                            fit: BoxFit.fitHeight,
                            color: UiConstants.kColorBase02,
                            colorBlendMode: BlendMode.darken,
                            errorWidget: (context, url, error) {
                              return Container(
                                color: UiConstants.kColorBase04,
                              );
                            },
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => Colors.transparent),
                onTap: () => BlocProvider.of<CartCubit>(context)
                    .removeFromCart(cartProduct),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TomasIconButton(
                      onPressed: () => BlocProvider.of<CartCubit>(context)
                          .removeFromCart(cartProduct),
                      iconPath: Paths.deleteIconPath,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      LocaleKeys.kTextDelete.tr(),
                      style: UiConstants.kTextStyleText5
                          .copyWith(color: UiConstants.kColorBase05),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => onTapProduct(context, product),
              child: Text(
                product.name,
                style: UiConstants.kTextStyleText2
                    .copyWith(color: UiConstants.kColorBase05),
              ),
            ),
          ),
          if (cartProduct.selectedOptionsIds.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                CartItemOptions(
                  cartProduct: cartProduct,
                ),
              ],
            ),
          const SizedBox(
            height: 32,
          ),
          Container(
            height: 44,
            width: 198,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: UiConstants.kColorBase03),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: BlocBuilder<CartViewQuantityCubit, CartViewQuantityState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () =>
                            BlocProvider.of<CartViewQuantityCubit>(context)
                                .decrease(),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: TomasIconButton(
                            onPressed: () =>
                                BlocProvider.of<CartViewQuantityCubit>(context)
                                    .decrease(),
                            iconPath: Paths.minusIconPath,
                          ),
                        ),
                      ),
                      Text(
                        state.itemCount.toString(),
                        style: UiConstants.kTextStyleText4.copyWith(
                            color: UiConstants.kColorBase05,
                            fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () =>
                            BlocProvider.of<CartViewQuantityCubit>(context)
                                .increase(),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: TomasIconButton(
                            onPressed: () =>
                                BlocProvider.of<CartViewQuantityCubit>(context)
                                    .increase(),
                            iconPath: Paths.plusIconPath,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${product.specialPrice ?? product.price} ₽",
                      style: UiConstants.kTextStylePriceSemiBold1
                          .copyWith(color: UiConstants.kColorText01)),
                  const SizedBox(
                    width: 32,
                  ),
                  product.specialPrice != null
                      ? RichText(
                          text: TextSpan(
                            text: "${product.price} ₽",
                            style: UiConstants.kTextStylePriceRegular1.copyWith(
                              color: UiConstants.kColorText05,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: UiConstants.kColorText05,
                              decorationThickness: 2.0,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ],
          )
        ],
      );
    }
    return Container();
  }

  onTapProduct(BuildContext context, Product product) {
    NavigationHelper.addRoute(
      context,
      CustomRoute(
          title: product.name,
          path: '${Routes.productScreen.path}&id=${product.id}'),
    );
  }
}
