import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_icon_button.dart';
import 'package:tomas_matres/ui/components/tomas_notification_widget/cubit/tomas_notification_widget_cubit.dart';

class TomasNotificationWidgetExpandedMobile extends StatefulWidget {
  const TomasNotificationWidgetExpandedMobile({super.key});

  @override
  State<TomasNotificationWidgetExpandedMobile> createState() =>
      _TomasNotificationWidgetExpandedMobileState();
}

class _TomasNotificationWidgetExpandedMobileState
    extends State<TomasNotificationWidgetExpandedMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController resultListAnimationController;
  late Animation<double> resultListAnimation;

  Timer? autoCollapseTimer;

  @override
  void initState() {
    super.initState();

    resultListAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 250),
    );

    resultListAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: resultListAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    autoCollapseTimer?.cancel(); // Отменяем таймер при удалении состояния
    resultListAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TomasNotificationWidgetCubit,
        TomasNotificationWidgetState>(
      listener: (context, state) =>
          onTopMenuFavoriteStateChange(context, state),
      builder: (context, state) {
        if (state is TomasNotificationWidgetHiddenState) {
          return Container();
        }

        return SizeTransition(
          sizeFactor: resultListAnimation,
          axis: Axis.horizontal,
          axisAlignment: 1.0,
          child: Container(
            width: 350,
            height: 70,
            decoration: BoxDecoration(
                color: UiConstants.kColorBase01,
                border: Border.all(color: UiConstants.kColorPrimary),
                borderRadius: BorderRadius.circular(24)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.notifications_active,
                    color: UiConstants.kColorPrimary,
                    size: 25,
                  ),
                ),
                const VerticalDivider(
                  width: 3,
                  color: UiConstants.kColorPrimary,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (state is TomasNotificationWidgetExpandedState)
                            ? state.text.toString()
                            : (state is TomasNotificationWidgetCollapsedState)
                                ? state.text.toString()
                                : '',
                        maxLines: 3,
                        style: UiConstants.kTextStyleText3
                            .copyWith(color: UiConstants.kColorBase05),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  width: 3,
                  color: UiConstants.kColorPrimary,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TomasIconButton(
                    onPressed: () =>
                        BlocProvider.of<TomasNotificationWidgetCubit>(context)
                            .collapse(),
                    iconPath: Paths.xIconPath,
                    width: 17,
                    iconColor: UiConstants.kColorPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onTopMenuFavoriteStateChange(
      BuildContext context, TomasNotificationWidgetState state) {
    if (state is TomasNotificationWidgetExpandedState) {
      autoCollapseTimer
          ?.cancel(); // Отменяем предыдущий таймер, если он существует
      autoCollapseTimer = Timer(const Duration(seconds: 5), () {
        BlocProvider.of<TomasNotificationWidgetCubit>(context).collapse();
      });
      resultListAnimationController.forward();
    }

    if (state is TomasNotificationWidgetCollapsedState) {
      autoCollapseTimer?.cancel(); // Отменяем таймер при сворачивании
      resultListAnimationController.reverse();
    }
  }
}
