import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/mobile/mobile_tomas_outlined_button.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_text_button.dart';
import 'package:tomas_matres/ui/components/products_grid_view/products_grid_view.dart';

class TomasScreenElementWithProducts extends StatelessWidget {
  final List<Product> products;
  final String title;
  final String? allOffersTopButtonText;
  final String? allOffersBottomButtonText;
  final VoidCallback? onAllOffersTopButtonPress;
  final VoidCallback? onAllOffersBottomButtonPress;
  final int countOfRaws;
  const TomasScreenElementWithProducts({
    super.key,
    required this.products,
    required this.title,
    this.allOffersBottomButtonText,
    this.allOffersTopButtonText,
    this.onAllOffersTopButtonPress,
    this.onAllOffersBottomButtonPress,
    this.countOfRaws = 2,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Container();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: UiConstants.kTextStyleHeadline2
                    .copyWith(color: UiConstants.kColorText01),
              ),
              if (allOffersTopButtonText != null)
                TomasTextButton(
                  onPressed: () => onAllOffersTopButtonPress != null
                      ? onAllOffersTopButtonPress!()
                      : {},
                  text: allOffersTopButtonText ?? '',
                  textStyle: UiConstants.kTextStyleText1.copyWith(height: 1),
                  foregroundColor: UiConstants.kColorLink,
                )
            ],
          ),
        ),
        ProductsGridView(
          products: products,
        ),
        if (allOffersBottomButtonText != null)
          MobileTomasOutlinedButton(
            onPressed: () => onAllOffersBottomButtonPress != null
                ? onAllOffersBottomButtonPress!()
                : {},
            text: allOffersBottomButtonText ?? '',
          )
      ],
    );
  }
}
