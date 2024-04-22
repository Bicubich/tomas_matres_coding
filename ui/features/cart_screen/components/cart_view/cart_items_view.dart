import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cart_item/cart_item.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/quantity/cart_view_quantity_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/cart_product_model.dart';

class CartItemsView extends StatelessWidget {
  const CartItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: UiConstants.kColorBase01),
      constraints: const BoxConstraints(
        maxHeight: 800,
        minHeight: 160,
      ),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return ListView.builder(
                itemCount: state.cartProducts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final CartProduct cartProduct = state.cartProducts[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocProvider(
                        create: (context) => CartViewQuantityCubit(
                            cartProduct: cartProduct,
                            cartCubit: BlocProvider.of<CartCubit>(context)),
                        child: CartItem(
                          cartProduct: cartProduct,
                        ),
                      ),
                      if (state.cartProducts.length > 1 &&
                          index != state.cartProducts.length - 1)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 48.0),
                          child: Divider(
                            color: UiConstants.kColorBase03,
                            height: 1,
                          ),
                        ),
                    ],
                  );
                });
          }

          if (state is CartNoData) {
            return Container(
              height: 160,
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.kTextEmptyCartMessage.tr(),
                style: UiConstants.kTextStyleText1,
              ),
            );
          }

          double height = 160;
          if (state is CartLoading) {
            if (state.totalCount > 1) {
              height = 266.6 * state.totalCount;
            }
          }

          return SizedBox(height: height, child: const TomasLoadIndicator());
        },
      ),
    );
  }
}
