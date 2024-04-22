import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_notification_widget/cubit/tomas_notification_widget_cubit.dart';
import 'package:tomas_matres/ui/components/tomas_outlined_with_icon_button.dart';
import 'package:tomas_matres/ui/components/tomas_filled_icon_with_text_button.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';

class TomasAddToCartButton extends StatelessWidget {
  final Product productToAdd;
  final Map<String, String>? selectedRadioOptions;
  final Map<String, List<String>>? selectedCheckboxOptions;
  final double iconHeight;
  final double iconWidth;
  final EdgeInsets buttonPadding;
  final VoidCallback? onPressed;
  final double textSize;

  const TomasAddToCartButton(
      {required this.productToAdd,
      this.selectedRadioOptions,
      this.selectedCheckboxOptions,
      required this.iconWidth,
      required this.iconHeight,
      required this.buttonPadding,
      this.onPressed,
      super.key,
      this.textSize = 18});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cartProducts.isNotEmpty) {
            int cartProductIndex = state.cartProducts
                .indexWhere((element) => element.productId == productToAdd.id);

            if (cartProductIndex != -1) {
              return TomasOutlinedWithIconButton(
                  onPressed: () => BlocProvider.of<CartCubit>(context)
                      .removeFromCart(state.cartProducts[cartProductIndex]),
                  iconPath: Paths.checkIconPath,
                  text: LocaleKeys.kTextProductInCart.tr(),
                  textColor: UiConstants.kColorLink,
                  iconColor: UiConstants.kColorPrimary,
                  textStyle:
                      UiConstants.kTextStyleText3.copyWith(fontSize: textSize),
                  iconHeight: iconHeight,
                  iconWidth: iconWidth,
                  buttonPadding: buttonPadding);
            }
          }
        }

        return TomasFilledIconWithTextButton(
          onPressed: () => onButtonPress(context),
          iconPath: Paths.cartIconPath,
          text: LocaleKeys.kTextAddToCart.tr(),
          textStyle: UiConstants.kTextStyleText3,
          active: true,
          iconHeight: iconHeight,
          iconWidth: iconWidth,
          disabledButtonColor: UiConstants.kColorBase01,
          disabledTextColor: UiConstants.kColorLink,
          disabledIconColor: UiConstants.kColorPrimary,
          asSmallAsPossible: false,
          buttonPadding: buttonPadding,
        );
      },
    );
  }

  void onButtonPress(BuildContext context) {
    if (onPressed != null) {
      onPressed!();
    }

    for (Option option in productToAdd.options) {
      if (option.required == '1') {
        if (option.type == 'checkbox') {
          if (selectedCheckboxOptions == null ||
              !(selectedCheckboxOptions!.containsKey(option.productOptionId))) {
            // Если опция обязательна и список пустой или в списке нет опции, то ничего не делаем и присылаем уведомление
            BlocProvider.of<TomasNotificationWidgetCubit>(context)
                .expand(text: LocaleKeys.kTextErrorOptionsNotSelected.tr());
            return;
          }
        }
        if (option.type == 'radio') {
          if (selectedRadioOptions == null ||
              !(selectedRadioOptions!.containsKey(option.productOptionId))) {
            // Если опция обязательна и список пустой или в списке нет опции, то ничего не делаем и присылаем уведомление
            BlocProvider.of<TomasNotificationWidgetCubit>(context)
                .expand(text: LocaleKeys.kTextErrorOptionsNotSelected.tr());
            return;
          }
        }
      }
    }

    Map<String, dynamic> options = {};
    if (selectedCheckboxOptions != null) {
      selectedCheckboxOptions!.forEach((key, value) {
        options[key] = value;
      });
    }
    if (selectedRadioOptions != null) {
      selectedRadioOptions!.forEach((key, value) {
        options[key] = value;
      });
    }

    BlocProvider.of<CartCubit>(context)
        .addToCart(productToAdd, options: options.isNotEmpty ? options : null);
  }
}
