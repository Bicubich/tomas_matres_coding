import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/card/products_list_card.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_add_to_cart_button.dart';
import 'package:tomas_matres/ui/components/tomas_text_button.dart';

class ProductsListCardExpanded extends StatefulWidget {
  final Product product;

  const ProductsListCardExpanded({
    required this.product,
    super.key,
  });

  @override
  State<ProductsListCardExpanded> createState() =>
      _ProductsListCardExpandedState();
}

class _ProductsListCardExpandedState extends State<ProductsListCardExpanded> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ProductsListCard(
            product: widget.product,
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
              height: 48,
              child: TomasAddToCartButton(
                productToAdd: widget.product,
                iconHeight: 24,
                iconWidth: 24,
                buttonPadding: const EdgeInsets.symmetric(horizontal: 40),
                onPressed: () => navigateToProduct(),
              )),
          const SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.center,
            child: TomasTextButton(
                onPressed: () => navigateToProduct(),
                foregroundColor: UiConstants.kColorLink,
                text: LocaleKeys.kTextMoreInfoAboutGood.tr()),
          ),
        ],
      ),
    );
  }

  void navigateToProduct() {
    NavigationHelper.addRoute(
        context,
        CustomRoute(
            title: widget.product.name,
            path: '${Routes.productScreen.path}&id=${widget.product.id}'));
  }
}
