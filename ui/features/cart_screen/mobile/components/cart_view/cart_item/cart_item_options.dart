import 'package:flutter/material.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/cart_product_model.dart';
import 'package:tomas_matres/ui/features/cart_screen/mobile/components/cart_view/cart_item/cart_item_option.dart';

class CartItemOptions extends StatelessWidget {
  final CartProduct cartProduct;

  const CartItemOptions({required this.cartProduct, super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [];
    for (String key in cartProduct.selectedOptionsIds.keys) {
      if (cartProduct.product != null) {
        Option option = cartProduct.product!.options
            .firstWhere((element) => element.productOptionId == key);

        if (option.type == 'radio') {
          final ProductOptionValue optionValue = option.productOptionValue
              .firstWhere((element) =>
                  element.productOptionValueId ==
                  cartProduct.selectedOptionsIds[key]);
          String name = optionValue.name;
          String price = optionValue.price.split('.').first;
          options.add(Padding(
            padding: const EdgeInsets.only(top: 5),
            child: CartItemOption(
                optionName: option.name,
                optionValueName: name,
                pricePrefix: optionValue.pricePrefix,
                price: price),
          ));
        }

        if (option.type == "checkbox") {
          for (ProductOptionValue optionValue in option.productOptionValue) {
            if (cartProduct.selectedOptionsIds[key]
                .contains(optionValue.productOptionValueId)) {
              String name = optionValue.name;
              String price = optionValue.price.split('.').first;

              options.add(Padding(
                padding: const EdgeInsets.only(top: 5),
                child: CartItemOption(
                    optionName: option.name,
                    optionValueName: name,
                    pricePrefix: optionValue.pricePrefix,
                    price: price),
              ));
            }
          }
        }
      }
    }
    return Column(
      //mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options,
    );
  }
}
