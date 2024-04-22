import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/cubit/animation/it_may_suit_animation_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/cubit/card_animation/it_may_suit_card_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/cubit/data/it_may_suit_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/components/it_may_suit_view.dart';

class ItMaySuitComponent extends StatefulWidget {
  const ItMaySuitComponent({super.key});

  @override
  State<ItMaySuitComponent> createState() => _ItMaySuitComponentState();
}

class _ItMaySuitComponentState extends State<ItMaySuitComponent>
    with TickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 250);
  late AnimationController _sizeAnimationController;
  late Animation<double> _sizeAnimation;
  late AnimationController _titleAlignAnimationController;
  late Animation<Alignment> _titleAlignAnimation;
  late AnimationController _buttonAlignAnimationController;
  late Animation<Alignment> _buttonAlignAnimation;
  late AnimationController _cardVisibilityAnimationController;
  late Animation<double> _cardVisibilityAnimation;
  late AnimationController _cardHeightAnimationController;
  late Animation<double> _cardHeightAnimation;
  late AnimationController _cardWidthAnimationController;
  late Animation<double> _cardWidthAnimation;
  late AnimationController _cardPaddingAnimationController;
  late Animation<double> _cardPaddingAnimation;
  late AnimationController _cardContentHeightAnimationController;
  late Animation<double> _cardContentHeightAnimation;
  bool forwardAnimationCompleted = false;
  bool reverseAnimationCompleted = true;

  @override
  void initState() {
    super.initState();
    initControllers();
    initListeners();
  }

  @override
  void dispose() {
    _sizeAnimationController.removeListener(() {});
    _sizeAnimationController.dispose();
    _titleAlignAnimationController.dispose();
    _buttonAlignAnimationController.dispose();
    _cardVisibilityAnimationController.dispose();
    _cardWidthAnimationController.dispose();
    _cardHeightAnimationController.dispose();
    _cardPaddingAnimationController.dispose();
    _cardContentHeightAnimationController.removeListener(() {});
    _cardContentHeightAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItMaySuitCubit, ItMaySuitState>(
      builder: (context, state) {
        if (state is ItMaySuitNoData) {
          return Container();
        }
        return BlocListener<ItMaySuitAnimationCubit, ItMaySuitAnimationState>(
          listener: (context, state) =>
              onItMaySuitAnimationStateChange(context, state),
          child: AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, child) {
                return Container(
                    height: _sizeAnimation.value,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: UiConstants.kColorBase01),
                    child: state is ItMaySuitLoaded
                        ? ItMaySuitView(
                            products: state.itMaySuitProducts,
                            titleAlignAnimation: _titleAlignAnimation,
                            buttonAlignAnimation: _buttonAlignAnimation,
                            cardWidthAnimation: _cardWidthAnimation,
                            cardHeightAnimation: _cardHeightAnimation,
                            cardPaddingAnimation: _cardPaddingAnimation,
                            cardVisibilityAnimation: _cardVisibilityAnimation,
                            cardContentHeightAnimation:
                                _cardContentHeightAnimation,
                            duration: duration,
                          )
                        : const TomasLoadIndicator());
              }),
        );
      },
    );
  }

  Future<void> onItMaySuitAnimationStateChange(
      BuildContext context, ItMaySuitAnimationState state) async {
    if (state is ItMaySuitAnimationExpanded) {
      await Future.wait([
        _titleAlignAnimationController.forward(),
        _buttonAlignAnimationController.forward(),
        _sizeAnimationController.forward(),
      ]).then((value) => {
            BlocProvider.of<ItMaySuitCardCubit>(context).show(),
            _cardVisibilityAnimationController.forward(),
          });
    }

    if (state is ItMaySuitAnimationCollapsed) {
      await _cardVisibilityAnimationController
          .reverse()
          .then((value) => BlocProvider.of<ItMaySuitCardCubit>(context).hide());

      await Future.wait([
        _cardPaddingAnimationController.reverse(),
        _cardWidthAnimationController.reverse(),
        _cardHeightAnimationController.reverse(),
        _cardContentHeightAnimationController.reverse(),
      ]);
    }
  }

  void initListeners() {
    _sizeAnimationController.addListener(() {
      if (_sizeAnimationController.value > 0.250 &&
          !forwardAnimationCompleted) {
        _cardPaddingAnimationController.forward();
        _cardWidthAnimationController.forward();
        _cardHeightAnimationController.forward();
        _cardContentHeightAnimationController
            .forward()
            .then((value) => reverseAnimationCompleted = false);

        forwardAnimationCompleted = true;
      }
    });

    _cardContentHeightAnimationController.addListener(() {
      if (_cardContentHeightAnimationController.value < 0.750 &&
          !reverseAnimationCompleted) {
        _sizeAnimationController
            .reverse()
            .then((value) => forwardAnimationCompleted = false);
        _titleAlignAnimationController.reverse();
        _buttonAlignAnimationController.reverse();

        reverseAnimationCompleted = true;
      }
    });
  }

  void initControllers() {
    // MAIN CONTAINER SIZE ANIMATION
    _sizeAnimationController = AnimationController(
      vsync: this,
      duration: duration,
    );

    _sizeAnimation = Tween<double>(
      begin: 240,
      end: 513,
    ).animate(_sizeAnimationController);

    // ALIGNMENT ANIMATIONS
    _titleAlignAnimationController = AnimationController(
      vsync: this,
      duration: duration,
    );

    _titleAlignAnimation = Tween<Alignment>(
      begin: Alignment.centerLeft,
      end: Alignment.topLeft,
    ).animate(_titleAlignAnimationController);

    _buttonAlignAnimationController = AnimationController(
      vsync: this,
      duration: duration,
    );

    _buttonAlignAnimation = Tween<Alignment>(
      begin: Alignment.centerRight,
      end: Alignment.topRight,
    ).animate(_buttonAlignAnimationController);

    // CARD ANIMATIONS
    _cardVisibilityAnimationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _cardVisibilityAnimation = Tween<double>(begin: 0, end: 1)
        .animate(_cardVisibilityAnimationController);

    _cardWidthAnimationController = AnimationController(
      vsync: this,
      duration: duration,
    );

    _cardWidthAnimation = Tween<double>(
      begin: 191,
      end: 280,
    ).animate(_cardWidthAnimationController);

    _cardPaddingAnimationController = AnimationController(
      vsync: this,
      duration: duration,
    );

    _cardPaddingAnimation = Tween<double>(
      begin: 7.5,
      end: 16,
    ).animate(_cardPaddingAnimationController);

    _cardHeightAnimationController = AnimationController(
      vsync: this,
      duration: duration,
    );

    _cardHeightAnimation = Tween<double>(
      begin: 110,
      end: 160,
    ).animate(_cardHeightAnimationController);

    _cardContentHeightAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 187));

    _cardContentHeightAnimation = Tween<double>(
      begin: 0,
      end: 147,
    ).animate(_cardContentHeightAnimationController);
  }
}
