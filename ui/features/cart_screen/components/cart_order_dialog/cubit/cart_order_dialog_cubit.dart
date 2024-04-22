// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/api/api.dart';
import 'package:tomas_matres/data_models/email_model.dart';
import 'package:tomas_matres/data_models/order/order_model.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/emails.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/success_order_model.dart';

part 'cart_order_dialog_state.dart';

class CartOrderDialogCubit extends Cubit<CartOrderDialogState> {
  final CartCubit cartCubit;
  final Address address;
  final String email;
  final String phone;
  final String comment;

  CartOrderDialogCubit(
      {required this.cartCubit,
      required this.address,
      required this.email,
      required this.phone,
      required this.comment})
      : super(CartOrderDialogLoadingState()) {
    _init();
  }

  Future<void> _init() async {
    try {
      SuccessOrder successOrder = await cartCubit.createOrder(
          address: address, email: email, phone: phone, comment: comment);

      TomasEmail userEmail = TomasEmail(
          to: 'val.evstigneev@mail.ru', //TODO Change to correct address
          subject: "Заказ №${successOrder.orderId} создан",
          message:
              "Ваш заказ №${successOrder.orderId} успешно создан"); //TODO Create correct notification

      await TomasApi.sendEmail(userEmail);

      TomasEmail adminEmail = TomasEmail(
          to: 'val.evstigneev@mail.ru', //TODO Change to correct address
          subject: "Новый заказ №${successOrder.orderId}!",
          message: Emails.newOrderAdminEmail(
              successOrder)); //TODO Create correct notification

      await TomasApi.sendEmail(adminEmail);

      await cartCubit.clearCart();

      emit(CartOrderDialogSuccessState(orderNumber: successOrder.orderId));
    } catch (e) {
      print(e);
      emit(CartOrderDialogErrorState());
    }
  }
}
