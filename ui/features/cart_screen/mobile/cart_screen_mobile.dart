import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/cart_screen/mobile/components/cart_view/cart_items_view.dart';
import 'package:tomas_matres/ui/features/cart_screen/mobile/components/it_may_suit/it_may_suit_mobile.dart';
import 'package:tomas_matres/ui/features/cart_screen/mobile/components/order_information/order_information_view.dart';
import 'package:tomas_matres/ui/features/cart_screen/mobile/components/summary_column/total_price.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/recommended_today/mobile/recommended_today_mobile.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';

class CartScreenMobile extends StatefulWidget {
  const CartScreenMobile({super.key});

  @override
  State<CartScreenMobile> createState() => _CartScreenMobileState();
}

class _CartScreenMobileState extends State<CartScreenMobile> {
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    return MobileTemplate(
      children: [
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: padding,
          child: Text(
            LocaleKeys.kTextMakingAnOrder.tr(),
            style: UiConstants.kTextStyleHeadline5
                .copyWith(color: UiConstants.kColorText01),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: padding,
          child: const SummaryColumnTotalPrice(),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: padding,
          child: const CartItemsView(),
        ),
        const SizedBox(height: 8),
        const ItMaySuitMobile(),
        const SizedBox(height: 40),
        Padding(
          padding: padding,
          child: const OrderInformationView(),
        ),
        const SizedBox(
          height: 80,
        ),
        const RecommendedTodayMobile(),
        const FooterMobile(),
      ],
    );
  }
}
