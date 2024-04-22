import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/common/navigation/navigation_widget.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/components/delivery_info/delivery_info.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/components/payment_container/content/another_payment_content.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/components/payment_container/content/payment_content.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/components/payment_container/content/return_payment_content.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/components/payment_container/payment_container.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/components/self_delivery_info/self_delivery_info.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/mobile/delivery_and_payment_screen_mobile.dart';
import 'package:tomas_matres/ui/features/template/template.dart';

class DeliveryAndPaymentScreen extends StatefulWidget {
  const DeliveryAndPaymentScreen({super.key});

  @override
  State<DeliveryAndPaymentScreen> createState() =>
      _DeliveryAndPaymentScreenState();
}

class _DeliveryAndPaymentScreenState extends State<DeliveryAndPaymentScreen> {
  final ScrollController scrollController = ScrollController();
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 40);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < UiConstants.minDesktopWidth) {
      return const DeliveryAndPaymentScreenMobile();
    }

    return PageTemplate(
      body: Expanded(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: Utils.calculatePadding(context)),
          controller: scrollController,
          shrinkWrap: true,
          children: [
            const NavigationWidget(),
            Padding(
              padding: padding,
              child: Text(LocaleKeys.kTextDeliveryAndPayment.tr(),
                  style: UiConstants.kTextStyleHeadline1.copyWith(
                    color: UiConstants.kColorText01,
                  )),
            ),
            const SizedBox(
              height: 49,
            ),
            Padding(
              padding: padding,
              child: const IntrinsicHeight(
                  child: Row(
                children: [
                  Expanded(
                      child: PaymentContainer(
                    content: PaymentContent(),
                  )),
                  SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PaymentContainer(content: AnotherPaymentContent()),
                        SizedBox(
                          height: 32,
                        ),
                        Expanded(
                            child: PaymentContainer(
                                content: ReturnPaymentContent()))
                      ],
                    ),
                  )
                ],
              )),
            ),
            const SizedBox(
              height: 120,
            ),
            Padding(
              padding: padding,
              child: const DeliveryInfo(),
            ),
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: padding,
              child: const SelfDeliveryInfo(),
            ),
            const SizedBox(
              height: 120,
            ),
            Footer(
              scrollController: scrollController,
            )
          ],
        ),
      ),
    );
  }
}
