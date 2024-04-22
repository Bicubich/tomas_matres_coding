import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomas_matres/api/constants.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/favorite_icon/favorite_icon_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/top_menu_favorite/top_menu_favorite_cubit.dart';

class MobileProductsGridCard extends StatelessWidget {
  final Product product;

  const MobileProductsGridCard({required this.product, super.key});

  double dynamicHeight(BuildContext context) {
    if (MediaQuery.of(context).size.width < 485) {
      return 213.w;
    } else {
      return 113.w;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Listener(
        onPointerDown: (event) => Utils.onPointerDown(
            context, event, '${Routes.productScreen.path}&id=${product.id}'),
        child: GestureDetector(
          onTap: () => onTap(context),
          onLongPressStart: (details) => Utils.onLongPress(context, details,
              '${Routes.productScreen.path}&id=${product.id}'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: dynamicHeight(context),
                      decoration: BoxDecoration(
                        color: UiConstants.kColorBase02,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: '${ApiConstants.imageUrl}${product.image}',
                        fit: BoxFit.fitHeight,
                        color: UiConstants.kColorBase02,
                        colorBlendMode: BlendMode.modulate,
                        errorWidget: (context, url, error) {
                          return Container(
                            color: UiConstants.kColorBase04,
                          );
                        },
                      ),
                    ),
                  ),
                  product.specialPrice != null
                      ? Positioned(
                          top: 9,
                          left: 13,
                          child: Container(
                            height: 26,
                            padding: const EdgeInsets.only(
                                top: 2, left: 12, right: 12),
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: UiConstants.kColorSecondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23),
                              ),
                            ),
                            child: Text(getSale(),
                                textAlign: TextAlign.center,
                                style: UiConstants.kTextStyleSpecial
                                    .copyWith(color: UiConstants.kColorText04)),
                          ),
                        )
                      : Container(),
                  Positioned(
                    top: 12,
                    right: 16,
                    child: BlocBuilder<FavoriteIconCubit, FavoriteIconState>(
                      builder: (context, state) {
                        return TomasIconButton(
                            onPressed: () {
                              if (state is FavoriteIconAdded) {
                                BlocProvider.of<TopMenuFavoriteCubit>(context)
                                    .removeFromFavorite(product);
                              } else {
                                BlocProvider.of<TopMenuFavoriteCubit>(context)
                                    .addToFavorite(product);
                              }
                            },
                            iconPath: Paths.likeIconPath,
                            width: 22,
                            height: 22,
                            iconColor: state is FavoriteIconAdded
                                ? UiConstants.kColorPrimaryActive
                                : null);
                      },
                    ),
                  ),
                  Visibility(
                    visible: isNew(),
                    child: Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        width: 27,
                        height: 27,
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          color: UiConstants.kColorBase01,
                          shape: OvalBorder(),
                        ),
                        child: Text('new',
                            textAlign: TextAlign.center,
                            style: UiConstants.kTextStyleText5.copyWith(
                                color: UiConstants.kColorText03,
                                fontSize: 10,
                                height: 1)),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Text(product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: UiConstants.kTextStyleText6
                        .copyWith(color: UiConstants.kColorText03)),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${product.specialPrice ?? product.price} ₽",
                        style: UiConstants.kTextStylePriceSemiBold3
                            .copyWith(color: UiConstants.kColorText01)),
                    const SizedBox(
                      width: 8,
                    ),
                    product.specialPrice != null
                        ? RichText(
                            text: TextSpan(
                              text: "${product.price} ₽",
                              style:
                                  UiConstants.kTextStylePriceRegular3.copyWith(
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
              )
            ],
          ),
        ),
      ),
    );
  }

  String getSale() {
    if (product.specialPrice != null) {
      final double sale =
          ((product.price - product.specialPrice!) / product.price) * 100;

      return '-${sale.round()}%';
    } else {
      return '';
    }
  }

  bool isNew() {
    DateTime dateAdded = product.dateAdded;
    DateTime dateNow = DateTime.now();
    bool isBefore = dateAdded
        .isBefore(DateTime(dateNow.year, dateNow.month - 1, dateNow.day));
    return !isBefore;
  }

  void onTap(BuildContext context) {
    NavigationHelper.addRoute(
        context,
        CustomRoute(
            title: product.name,
            path: '${Routes.productScreen.path}&id=${product.id}'));
  }
}
