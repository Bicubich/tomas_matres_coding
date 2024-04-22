import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/other/delivery_and_payment/mobile/delivery_mobile.dart';
import 'package:tomas_matres/ui/features/other/services/mobile/components/service_assembly_mobile.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';

class ServicesScreenMobile extends StatefulWidget {
  const ServicesScreenMobile({super.key});

  @override
  State<ServicesScreenMobile> createState() => _ServicesScreenMobileState();
}

class _ServicesScreenMobileState extends State<ServicesScreenMobile> {
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
          child: Text(LocaleKeys.kTextServices.tr(),
              style: UiConstants.kTextStyleHeadline5.copyWith(
                color: UiConstants.kColorText01,
              )),
        ),
        DeliveryMobile(
          backgroundColor: UiConstants.kColorBase01,
        ),
        const SizedBox(
          height: 40,
        ),
        ServiceAssemblyMobile(),
        const FooterMobile(),
      ],
    );
  }
}
