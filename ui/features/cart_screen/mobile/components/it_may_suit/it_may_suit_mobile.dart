import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/mobile/mobile_product_list_card.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_icon_with_text_button.dart';
import 'package:tomas_matres/ui/components/tomas_outlined_button.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/cubit/card_animation/it_may_suit_card_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/cubit/data/it_may_suit_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/cart_product_model.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/favorite_icon/favorite_icon_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/top_menu_favorite/top_menu_favorite_cubit.dart';
import 'package:collection/collection.dart';

class ItMaySuitMobile extends StatefulWidget {
  const ItMaySuitMobile({
    super.key,
  });

  @override
  State<ItMaySuitMobile> createState() => _ItMaySuitMobileState();
}

class _ItMaySuitMobileState extends State<ItMaySuitMobile> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItMaySuitCardCubit(),
      child: BlocBuilder<ItMaySuitCubit, ItMaySuitState>(
        builder: (context, itMaySuitState) {
          if (itMaySuitState is ItMaySuitLoaded) {
            return SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      LocaleKeys.kTextItMaySuitYou.tr(),
                      style: UiConstants.kTextStyleHeadline5
                          .copyWith(color: UiConstants.kColorText01),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    height: 328,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: RawScrollbar(
                        thickness: 2,
                        thumbColor: UiConstants.kColorSecondary,
                        trackColor: Colors.transparent,
                        controller: scrollController,
                        thumbVisibility: true,
                        trackVisibility: true,
                        crossAxisMargin: 15,
                        trackBorderColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          itemCount: itMaySuitState.itMaySuitProducts.length,
                          controller: scrollController,
                          padding: const EdgeInsets.only(left: 16),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return BlocProvider(
                              create: (context) => FavoriteIconCubit(
                                  productId: itMaySuitState
                                      .itMaySuitProducts[index].id,
                                  topMenuFavoriteCubit:
                                      BlocProvider.of<TopMenuFavoriteCubit>(
                                          context)),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () => navigateToProduct(
                                        itMaySuitState
                                            .itMaySuitProducts[index]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MobileProductsListCard(
                                          product: itMaySuitState
                                              .itMaySuitProducts[index],
                                          isFavoriteAddVisible: false,
                                          isNewChipVisible: false,
                                          isSaleChipVisible: false,
                                        ),
                                        BlocBuilder<CartCubit, CartState>(
                                          builder: (context, cartState) =>
                                              isItemInCard(
                                                      cartState,
                                                      itMaySuitState
                                                              .itMaySuitProducts[
                                                          index])
                                                  ? TomasIconWithTextButton(
                                                      onPressed: () =>
                                                          onTapDeleteItemCart(
                                                        context,
                                                        itMaySuitState
                                                                .itMaySuitProducts[
                                                            index],
                                                      ),
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
                                                    )
                                                  : TomasOutlinedButton(
                                                      onPressed: () =>
                                                          onTapAddCart(
                                                        context,
                                                        itMaySuitState
                                                                .itMaySuitProducts[
                                                            index],
                                                      ),
                                                      text: LocaleKeys.kTextAdd
                                                          .tr(),
                                                    ),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  onTapAddCart(BuildContext context, Product product) {
    bool isNeedSelectOption = false;
    if (product.options.isNotEmpty) {
      for (Option option in product.options) {
        if (option.required == '1') {
          isNeedSelectOption = true;
          navigateToProduct(product);
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

  void navigateToProduct(Product product) {
    var route = CustomRoute(
        title: Routes.productScreen.title,
        path: '${Routes.productScreen.path}&id=${product.id}');
    NavigationHelper.replaceRoute(context, route);
  }

  bool isItemInCard(CartState state, Product product) {
    bool isInCart = false;
    if (state is CartLoaded) {
      if (state.cartProducts.isNotEmpty) {
        int cartProductIndex = state.cartProducts
            .indexWhere((element) => element.productId == product.id);

        if (cartProductIndex != -1) {
          isInCart = true;
        }
      }
    }
    return isInCart;
  }
}
