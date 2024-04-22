import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/components/receiving_method/bloc/receiving_method_bloc.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/components/receiving_method/receiving_method_enum.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/components/receiving_method/receiving_method_item.dart';

class ReceivingMethodView extends StatefulWidget {
  const ReceivingMethodView({super.key});

  @override
  State<ReceivingMethodView> createState() => _ReceivingMethodViewState();
}

class _ReceivingMethodViewState extends State<ReceivingMethodView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.kTextSelectTheMethodOfReceipt.tr(),
          style: UiConstants.kTextStyleText4
              .copyWith(color: UiConstants.kColorBase05),
        ),
        const SizedBox(
          height: 40,
        ),
        BlocBuilder<ReceivingMethodBloc, ReceivingMethodState>(
          builder: (context, state) {
            return Row(
              children: [
                ReceivingMethodItem(
                  label: LocaleKeys.kTextDelivery.tr(),
                  iconPath: Paths.carIconPath,
                  receivingType: ReceivingType.delivery,
                ),
                const SizedBox(
                  width: 40,
                ),
                ReceivingMethodItem(
                  label: LocaleKeys.kTextDeliveryInfoSelfDelivery.tr(),
                  iconPath: Paths.boxIconPath,
                  receivingType: ReceivingType.payment,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
