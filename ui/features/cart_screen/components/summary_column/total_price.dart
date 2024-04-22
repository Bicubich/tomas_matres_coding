import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_count_up_price.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/info_dropdown/bloc/total_dropdown_item_bloc.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/info_dropdown/bloc/total_dropdown_item_state.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/info_dropdown/components/info_dropdown_delivery.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/info_dropdown/components/info_dropdown_payment.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/info_dropdown/info_dropdown.dart';

class SummaryColumnTotalPrice extends StatelessWidget {
  const SummaryColumnTotalPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${LocaleKeys.kTextDiscount.tr()}:',
              style: UiConstants.kTextStyleText2
                  .copyWith(color: UiConstants.kColorText02, height: 1),
            ),
            const SizedBox(
              width: 16.0,
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return TomasCountUpPrice(
                  price: state is CartLoaded ? state.totalSale : 0,
                  textStyle: UiConstants.kTextStylePriceSemiBold2
                      .copyWith(color: UiConstants.kColorText02),
                );
              },
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 25.0),
          child: Divider(
            color: UiConstants.kColorBase03,
            height: 1,
          ),
        ),
        Text(
          LocaleKeys.kTextTotalToBePaid.tr(),
          style: UiConstants.kTextStyleText4
              .copyWith(color: UiConstants.kColorBase04),
        ),
        const SizedBox(
          height: 19.0,
        ),
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Row(
              children: [
                TomasCountUpPrice(
                  price: state is CartLoaded
                      ? (state.totalToPayWithSale == 0
                          ? state.totalToPay
                          : state.totalToPayWithSale)
                      : 0,
                  textStyle: UiConstants.kTextStyleHeadline5.copyWith(
                      color: UiConstants.kColorText01,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 24,
                ),
                TomasCountUpPrice(
                  price: state is CartLoaded ? state.totalToPay : 0,
                  textStyle: UiConstants.kTextStylePriceRegular1.copyWith(
                    color: UiConstants.kColorBase04,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2.0,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                )
              ],
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.only(top: 56.0, bottom: 24),
          child: Divider(
            color: UiConstants.kColorBase03,
            height: 1,
          ),
        ),
        BlocProvider(
          create: (context) => TotalPriceBloc(),
          child: BlocBuilder<TotalPriceBloc, TotalPriceState>(
            builder: (context, state) {
              return SummaryColumnInfoDropdown(
                title: LocaleKeys.kTextDelivery.tr(),
                body: const SummaryColumnInfoDropdownDelivery(),
              );
            },
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        BlocProvider(
          create: (context) => TotalPriceBloc(),
          child: BlocBuilder<TotalPriceBloc, TotalPriceState>(
            builder: (context, state) {
              return SummaryColumnInfoDropdown(
                title: LocaleKeys.kTextPayment.tr(),
                body: const SummaryColumnInfoDropdownPayment(),
              );
            },
          ),
        ),
      ],
    );
  }
}
