import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_order_dialog/cart_order_dialog_error.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_order_dialog/cart_order_dialog_success.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_order_dialog/cubit/cart_order_dialog_cubit.dart';

class CartOrderDialog extends StatelessWidget {
  const CartOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      insetPadding: const EdgeInsets.all(0),
      child: Container(
          constraints: const BoxConstraints(
              minWidth: 440, maxWidth: 440, minHeight: 380, maxHeight: 440),
          decoration: BoxDecoration(
              color: UiConstants.kColorBase01,
              borderRadius: BorderRadius.circular(24)),
          child: BlocBuilder<CartOrderDialogCubit, CartOrderDialogState>(
            builder: (context, state) {
              if (state is CartOrderDialogSuccessState) {
                return CartOrderDialogSuccess(orderNumber: state.orderNumber);
              }

              if (state is CartOrderDialogErrorState) {
                return const CartOrderDialogError();
              }

              return const TomasLoadIndicator();
            },
          )),
    );
  }
}
