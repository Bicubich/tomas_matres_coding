import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_order_dialog/cubit/cart_order_dialog_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/mobile/components/cart_order/cart_order_error.dart';
import 'package:tomas_matres/ui/features/cart_screen/mobile/components/cart_order/cart_order_success.dart';

class CartOrderView extends StatelessWidget {
  const CartOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 326,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Align(
              alignment: Alignment.topRight,
              child: TomasIconButton(
                onPressed: () => Navigator.pop(context),
                iconPath: Paths.xIconPath,
                width: 24,
                height: 24,
                iconColor: UiConstants.kColorBase05,
              ),
            ),
          ),
          const SizedBox(
            height: 34,
          ),
          BlocBuilder<CartOrderDialogCubit, CartOrderDialogState>(
            builder: (context, state) {
              if (state is CartOrderDialogSuccessState) {
                return CartOrderDialogSuccess(orderNumber: state.orderNumber);
              }

              if (state is CartOrderDialogErrorState) {
                return const CartOrderDialogError();
              }

              return const TomasLoadIndicator();
            },
          )
        ],
      ),
    );
  }
}
