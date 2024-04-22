import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_error_text.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/components/tomas_outlined_button.dart';
import 'package:tomas_matres/ui/features/Included_in_package/cubit/included_in_package_cubit.dart';
import 'package:tomas_matres/ui/features/Included_in_package/included_in_package.dart';
import 'package:tomas_matres/ui/features/product_screen/components/price/cubit/product_info_price_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/product_gallery/cubit/product_gallery_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/components/product_gallery/product_gallery.dart';
import 'package:tomas_matres/ui/features/product_screen/components/product_image.dart';
import 'package:tomas_matres/ui/features/product_screen/components/product_screen_two_list_view_template.dart';
import 'package:tomas_matres/ui/features/product_screen/cubit/product_screen_cubit.dart';
import 'package:tomas_matres/ui/features/product_screen/mobile/product_screen_mobile.dart';
import 'package:tomas_matres/ui/features/recommended_today/recommended_today.dart';
import 'package:tomas_matres/ui/features/they_buy_with_it/cubit/they_buy_with_it_cubit.dart';
import 'package:tomas_matres/ui/features/they_buy_with_it/they_buy_with_it.dart';

class ProductScreen extends StatefulWidget {
  final String? productId;
  final Product? product;
  final String routePath;
  const ProductScreen(
      {required this.productId,
      this.product,
      required this.routePath,
      super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 40);

  final List<String> allImages = [];

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < UiConstants.minDesktopWidth) {
      return ProductScreenMobile(
        productId: widget.productId,
        routePath: widget.routePath,
        product: widget.product,
      );
    }

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
        builder: (context, state) {
          if (state is ProductScreenLoaded) {
            return BlocProvider(
              create: (context) => ProductInfoPriceCubit(
                  price: state.product.price,
                  special: state.product.specialPrice),
              child: ProductScreenTwoListViewPageTemplate(
                routePath: widget.routePath,
                leftColumnWidgets: generateImagesColumn(),
                product: state.product,
                bottomWidgets: [
                  const SizedBox(
                    height: 120,
                  ),
                  BlocBuilder<IncludedInPackageCubit, IncludedInPackageState>(
                    builder: (context, state) {
                      if (state is IncludedInPackageLoaded) {
                        return IncludedInPackage(products: state.products);
                      } else {
                        return Container();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<TheyBuyWithItCubit, TheyBuyWithItState>(
                    builder: (context, state) {
                      if (state is TheyBuyWithItLoaded) {
                        return TheyBuyWithIt(products: state.products);
                      } else {
                        return Container();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: padding,
                    child: const RecommendedToday(),
                  ),
                ],
                leftColumnFlex: 2,
                rightColumnFlex: 1,
                loading: state is ProductScreenLoading,
              ),
            );
          }

          if (state is ProductScreenLoading) {
            return const SizedBox(height: 400, child: TomasLoadIndicator());
          }

          return const TomasErrorText();
        },
      ),
    );
  }

  List<Widget> generateImagesColumn() {
    List<Widget> result = [];

    result.add(Padding(
        padding:
            EdgeInsets.only(left: 40, bottom: allImages.length > 1 ? 32 : 0),
        child: IgnorePointer(
          ignoring: allImages.length <= 2,
          ignoringSemantics: true,
          child: InkWell(
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            onTap: () => openProductGallery(),
            child: ProductImage(
              image: allImages[0],
              height: 600,
            ),
          ),
        )));
    if (allImages.length > 1) {
      result.add(Padding(
          padding:
              EdgeInsets.only(left: 40, bottom: allImages.length > 2 ? 48 : 0),
          child: IgnorePointer(
            ignoring: allImages.length <= 2,
            child: InkWell(
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => openProductGallery(initImageIndex: 1),
              child: ProductImage(
                image: allImages[1],
                height: 600,
              ),
            ),
          )));
    }
    if (allImages.length > 2) {
      result.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            width: 280,
            child: TomasOutlinedButton(
                onPressed: () => openProductGallery(),
                text: LocaleKeys.kTextOpenGallery.tr()),
          ),
        ],
      ));
    }

    result.add(const SizedBox(
      height: 24,
    ));

    return result;
  }

  openProductGallery({int? initImageIndex}) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => ProductGalleryCubit(
                images: allImages, mainImageIndex: initImageIndex),
            child: const ProductGallery(),
          );
        });
  }
}
