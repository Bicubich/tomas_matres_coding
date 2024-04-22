import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/mobile/mobile_tomas_product_horizontal_scroll_view.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_error_text.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/components/tomas_notification_widget/cubit/tomas_notification_widget_cubit.dart';
import 'package:tomas_matres/ui/features/Included_in_package/cubit/included_in_package_cubit.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/cubit/top_menu_favorite/top_menu_favorite_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/price/cubit/product_info_price_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/cubit/product_screen_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/cubit/product_screen_favorite_icon/product_screen_favorite_icon_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/mobile/components/product_gallery/cubit/product_gallery_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/mobile/components/product_gallery/product_gallery_mobile.dart';
import 'package:tomas_matres/ui/features/product_screen/mobile/components/product_info.dart';
import 'package:tomas_matres/ui/features/product_screen/mobile/components/product_screen_image_slider.dart';
import 'package:tomas_matres/ui/features/recommended_today/mobile/recommended_today_mobile.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';
import 'package:tomas_matres/ui/features/they_buy_with_it/cubit/they_buy_with_it_cubit.dart';

class ProductScreenMobile extends StatefulWidget {
  final String? productId;
  final Product? product;
  final String routePath;
  const ProductScreenMobile(
      {required this.productId,
      this.product,
      required this.routePath,
      super.key});

  @override
  State<ProductScreenMobile> createState() => _ProductScreenMobileState();
}

class _ProductScreenMobileState extends State<ProductScreenMobile> {
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16);

  final List<String> allImages = [];

  final Map<String, String> selectedRadioOptions = {};
  final Map<String, List<String>> selectedCheckboxOptions = {};

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductScreenCubit(
            productId: widget.productId,
            product: widget.product,
          ),
        ),
        BlocProvider(
          create: (context) => IncludedInPackageCubit(
              productScreenCubit: BlocProvider.of<ProductScreenCubit>(context)),
        ),
        BlocProvider(
          create: (context) => TheyBuyWithItCubit(
              productScreenCubit: BlocProvider.of<ProductScreenCubit>(context)),
        ),
        BlocProvider(
          create: (context) => ProductGalleryCubit(),
        ),
      ],
      child: BlocConsumer<ProductScreenCubit, ProductScreenState>(
        listener: (context, state) {
          if (state is ProductScreenErrorNotFound) {
            NavigationHelper.replaceRoute(context, Routes.notFound);
          }
          if (state is ProductScreenLoaded) {
            allImages.clear();
            allImages.add(state.product.image);
            if (state.product.additionalImages.isNotEmpty) {
              allImages.addAll(state.product.additionalImages);
            }
          }
        },
        builder: (context, productScreenLoaded) {
          if (productScreenLoaded is ProductScreenLoaded) {
            return BlocProvider(
              create: (context) => ProductInfoPriceCubit(
                  price: productScreenLoaded.product.price,
                  special: productScreenLoaded.product.specialPrice),
              child: Stack(
                children: [
                  MobileTemplate(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: padding,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                productScreenLoaded.product.name,
                                style: UiConstants.kTextStyleHeadline5.copyWith(
                                  color: UiConstants.kColorText01,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            BlocProvider(
                              create: (context) =>
                                  ProductScreenFavoriteIconCubit(
                                      productId: productScreenLoaded.product.id,
                                      topMenuFavoriteCubit:
                                          BlocProvider.of<TopMenuFavoriteCubit>(
                                              context)),
                              child: BlocBuilder<ProductScreenFavoriteIconCubit,
                                  ProductScreenFavoriteIconState>(
                                builder: (context, state) {
                                  return TomasIconButton(
                                      onPressed: () {
                                        if (state
                                            is ProductScreenFavoriteIconActive) {
                                          BlocProvider.of<TopMenuFavoriteCubit>(
                                                  context)
                                              .removeFromFavorite(
                                                  productScreenLoaded.product);
                                        } else {
                                          BlocProvider.of<TopMenuFavoriteCubit>(
                                                  context)
                                              .addToFavorite(
                                                  productScreenLoaded.product);
                                        }
                                      },
                                      iconPath: Paths.likeIconPath,
                                      width: 24,
                                      height: 24,
                                      iconColor: state
                                              is ProductScreenFavoriteIconActive
                                          ? UiConstants.kColorPrimaryActive
                                          : null);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ProductScreenImageSlider(
                          images: allImages,
                          onTapImage: () => openProductGallery(context)),
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: padding,
                        child: ProductInfo(
                          product: productScreenLoaded.product,
                        ),
                      ),
                      BlocBuilder<IncludedInPackageCubit,
                          IncludedInPackageState>(
                        builder: (context, state) {
                          if (state is IncludedInPackageLoaded) {
                            return Visibility(
                              visible: state.products.isNotEmpty,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  MobileTomasProductHorizontalScrollView(
                                    products: state.products,
                                    height: 354,
                                    title: LocaleKeys.kTextIncludedInThePackage
                                        .tr(),
                                    isTitleCenter: false,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      BlocBuilder<TheyBuyWithItCubit, TheyBuyWithItState>(
                        builder: (context, state) {
                          if (state is TheyBuyWithItLoaded) {
                            return Visibility(
                              visible: state.products.isNotEmpty,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  MobileTomasProductHorizontalScrollView(
                                    products: state.products,
                                    height: 354,
                                    title: LocaleKeys.kTextTheyBuyWithThis.tr(),
                                    isTitleCenter: false,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      const RecommendedTodayMobile(),
                      const SizedBox(
                        height: 80,
                      ),
                      const FooterMobile(),
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: ProductGalleryMobile(
                          images: allImages,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }

          if (productScreenLoaded is ProductScreenLoading) {
            return const SizedBox(height: 400, child: TomasLoadIndicator());
          }

          return const TomasErrorText();
        },
      ),
    );
  }

  void onAddToCartPress(ProductScreenLoaded productScreenLoaded) {
    if (productScreenLoaded.product.options.isNotEmpty) {
      for (Option option in productScreenLoaded.product.options) {
        if (option.required == '1') {
          BlocProvider.of<TomasNotificationWidgetCubit>(context)
              .expand(text: LocaleKeys.kTextErrorOptionsNotSelected.tr());
          return;
        }
      }
    }
  }

  openProductGallery(BuildContext context) {
    BlocProvider.of<ProductGalleryCubit>(context).expand();
  }
}
