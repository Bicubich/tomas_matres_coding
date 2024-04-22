import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/mobile/delivery_mobile.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/mobile/payment_mobile.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';

class DeliveryAndPaymentScreenMobile extends StatefulWidget {
  const DeliveryAndPaymentScreenMobile({super.key});

  @override
  State<DeliveryAndPaymentScreenMobile> createState() =>
      _DeliveryAndPaymentScreenMobileState();
}

class _DeliveryAndPaymentScreenMobileState
    extends State<DeliveryAndPaymentScreenMobile> {
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
          child: Text(LocaleKeys.kTextDeliveryAndPayment.tr(),
              style: UiConstants.kTextStyleHeadline5.copyWith(
                color: UiConstants.kColorText01,
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: padding,
          child: const PaymentMobile(),
        ),
        const SizedBox(
          height: 40,
        ),
        DeliveryMobile(
          backgroundColor: UiConstants.kColorBase02,
        ),
        const FooterMobile(),
      ],
    );
  }
}
