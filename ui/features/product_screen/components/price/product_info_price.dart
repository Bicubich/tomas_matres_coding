import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_count_up_price.dart';
import 'package:tomas_matres/ui/features/product_screen/components/price/cubit/product_info_price_cubit.dart';

class ProductInfoPrice extends StatefulWidget {
  final Product product;

  const ProductInfoPrice({required this.product, super.key});

  @override
  State<ProductInfoPrice> createState() => _ProductInfoPriceState();
}

class _ProductInfoPriceState extends State<ProductInfoPrice> {
  int currentPrice = 0;
  int oldPrice = 0;
  int? currentSpecial = 0;
  int? oldSpecial = 0;

  @override
  void initState() {
    super.initState();

    currentPrice = widget.product.price;
    currentSpecial = widget.product.specialPrice;
  }

  @override
  Widget build(BuildContext context) {
    bool isMobileDevice =
        MediaQuery.of(context).size.width < UiConstants.minDesktopWidth;
    return BlocConsumer<ProductInfoPriceCubit, ProductInfoPriceState>(
      listener: (context, state) {
        currentPrice = state.price;

        if (currentSpecial != null || state.special != null) {
          currentSpecial = state.special ?? currentSpecial;
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TomasCountUpPrice(
              price: currentSpecial == null
                  ? currentPrice.toDouble()
                  : currentSpecial!.toDouble(),
              textStyle: (isMobileDevice
                      ? UiConstants.kTextStyleHeadline5
                      : UiConstants.kTextStyleHeadline2)
                  .copyWith(
                      color: UiConstants.kColorText01,
                      fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 24,
            ),
            if (state.special != 0 && state.special != null)
              TomasCountUpPrice(
                price: currentPrice.toDouble(),
                textStyle: (isMobileDevice
                        ? UiConstants.kTextStylePriceRegular1
                        : UiConstants.kTextStyleText4)
                    .copyWith(
                  color: UiConstants.kColorBase04,
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 2.0,
                  height: 1,
                  fontSize: isMobileDevice ? null : 32,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              )
          ],
        );
      },
    );
  }
}
