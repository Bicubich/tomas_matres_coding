import 'package:flutter/material.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/mobile/components/another_payment_content_mobile.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/mobile/components/payment_content_mobile.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/mobile/components/return_payment_content_mobile.dart';

class PaymentMobile extends StatelessWidget {
  const PaymentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentContentMobile(),
        SizedBox(
          height: 80,
        ),
        AnotherPaymentContentMobile(),
        SizedBox(
          height: 80,
        ),
        ReturnPaymentContentMobile(),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
