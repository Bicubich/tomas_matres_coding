import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/api/constants.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/products_grid_view/bloc/product_grid_view_item_bloc.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/favorite_icon/favorite_icon_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/top_menu_favorite/top_menu_favorite_cubit.dart';

class ProductsListCard extends StatelessWidget {
  final Product product;

  const ProductsListCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 304,
              decoration: BoxDecoration(
                color: UiConstants.kColorBase02,
                borderRadius: BorderRadius.circular(24),
              ),
              child: BlocBuilder<ProductGridViewItemBloc,
                  ProductGridViewItemState>(
                builder: (context, state) {
                  bool expanded = state is ProductGridViewItemExpandedState &&
                      state.selected;

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: AnimatedScale(
                        scale: expanded ? 1.1 : 1,
                        duration: const Duration(milliseconds: 140),
                        child: CachedNetworkImage(
                          imageUrl: '${ApiConstants.imageUrl}${product.image}',
                          width: 436,
                          height: 304,
                          fit: BoxFit.fitHeight,
                          color: UiConstants.kColorBase02,
                          colorBlendMode: BlendMode.darken,
                          errorWidget: (context, url, error) {
                            return Container(
                              color: UiConstants.kColorBase04,
                            );
                          },
                        )),
                  );
                },
              ),
            ),
            product.specialPrice != null
                ? Positioned(
                    top: 14,
                    left: 16,
                    child: Container(
                      height: 26,
                      padding:
                          const EdgeInsets.only(top: 2, left: 12, right: 12),
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
              top: 17,
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
                      width: 20,
                      height: 20,
                      iconColor: state is FavoriteIconAdded
                          ? UiConstants.kColorPrimaryActive
                          : null);
                },
              ),
            ),
            Visibility(
              visible: isNew(),
              child: Positioned(
                bottom: 12,
                right: 16,
                child: Container(
                  width: 57,
                  height: 57,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    color: UiConstants.kColorBase01,
                    shape: OvalBorder(),
                  ),
                  child: Text('new',
                      textAlign: TextAlign.center,
                      style: UiConstants.kTextStyleText5
                          .copyWith(color: UiConstants.kColorText03)),
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
              style: UiConstants.kTextStyleText2
                  .copyWith(color: UiConstants.kColorText03)),
        ),
        Container(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
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
        )
      ],
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
}
