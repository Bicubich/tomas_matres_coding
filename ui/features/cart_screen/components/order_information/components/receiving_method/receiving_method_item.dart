import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/components/receiving_method/bloc/receiving_method_bloc.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/components/receiving_method/bloc/receiving_method_event.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/components/receiving_method/receiving_method_enum.dart';

class ReceivingMethodItem extends StatelessWidget {
  const ReceivingMethodItem(
      {super.key,
      required this.label,
      required this.iconPath,
      required this.receivingType});

  final String label;
  final String iconPath;
  final ReceivingType receivingType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceivingMethodBloc, ReceivingMethodState>(
      builder: (context, state) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => context.read<ReceivingMethodBloc>().add(
                  SwitchMethodEvent(
                      value: receivingType == ReceivingType.delivery),
                ),
            child: Row(
              children: [
                Radio(
                  fillColor:
                      const MaterialStatePropertyAll(UiConstants.kColorPrimary),
                  value: receivingType == ReceivingType.delivery,
                  groupValue: state.isDelivery,
                  onChanged: (value) => context.read<ReceivingMethodBloc>().add(
                        SwitchMethodEvent(
                            value: receivingType == ReceivingType.delivery),
                      ),
                ),
                const SizedBox(
                  width: 16,
                ),
                SvgPicture.asset(
                  "assets/$iconPath",
                  colorFilter: ColorFilter.mode(
                      receivingType == ReceivingType.delivery &&
                                  state.isDelivery ||
                              receivingType == ReceivingType.payment &&
                                  !state.isDelivery
                          ? UiConstants.kColorText02
                          : UiConstants.kColorText03,
                      BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  label,
                  style: UiConstants.kTextStyleText4.copyWith(
                      color: receivingType == ReceivingType.delivery &&
                                  state.isDelivery ||
                              receivingType == ReceivingType.payment &&
                                  !state.isDelivery
                          ? UiConstants.kColorBase05
                          : UiConstants.kColorBase04),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
