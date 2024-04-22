import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/ui/components/top_menu_background_shading/components/background_shading_triangle.dart';
import 'package:tomas_matres/ui/components/top_menu_background_shading/cubit/background_shading_cubit.dart';

class TomasBackgroundShading extends StatefulWidget {
  const TomasBackgroundShading({
    super.key,
  });

  @override
  State<TomasBackgroundShading> createState() => _TomasBackgroundShadingState();
}

class _TomasBackgroundShadingState extends State<TomasBackgroundShading>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 250),
    );

    opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 0.3,
    ).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    double mainPadding = Utils.calculatePadding(context);

    return BlocConsumer<BackgroundShadingCubit, BackgroundShadingState>(
      listener: (context, state) =>
          onBackgroundShadingStateChange(context, state),
      builder: (context, state) {
        if (state is BackgroundShadingHidden) {
          return Container();
        } else {
          return GestureDetector(
            onTap: () => onTapBackgroundShading(context),
            child: FadeTransition(
              opacity: opacityAnimation,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                          width: mainPadding,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.black)),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          width: mainPadding,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.black)),
                  state.roundHeaderBorders
                      ? Positioned(
                          left: mainPadding - 1,
                          top: 143,
                          child: const BackgroundShadingTriangle())
                      : Container(),
                  Positioned(
                      top: 171,
                      left: mainPadding - 1,
                      child: Container(
                          width: MediaQuery.of(context).size.width -
                              (mainPadding * 2) +
                              2,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.black)),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void onBackgroundShadingStateChange(
      BuildContext context, BackgroundShadingState state) {
    if (state is BackgroundShadingActive) {
      controller.forward();
    }
    if (state is BackgroundShadingInactive) {
      controller.reverse().then(
          (value) => BlocProvider.of<BackgroundShadingCubit>(context).hide());
    }
  }

  void onTapBackgroundShading(BuildContext context) {
    Utils.closeSearchWidget(context);
    Utils.closeTopMenuWidget(context);
    Utils.closeFavoriteWidget(context);
  }
}
