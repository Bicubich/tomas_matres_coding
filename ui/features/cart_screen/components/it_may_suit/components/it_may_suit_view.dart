import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_icon_with_text_button.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/components/it_may_suit_card.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/cubit/animation/it_may_suit_animation_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/cubit/card_animation/it_may_suit_card_cubit.dart';

class ItMaySuitView extends StatelessWidget {
  final List<Product> products;
  final Animation<Alignment> titleAlignAnimation;
  final Animation<Alignment> buttonAlignAnimation;
  final Animation<double> cardVisibilityAnimation;
  final Animation<double> cardWidthAnimation;
  final Animation<double> cardHeightAnimation;
  final Animation<double> cardPaddingAnimation;
  final Animation<double> cardContentHeightAnimation;
  final Duration duration;

  const ItMaySuitView(
      {required this.products,
      required this.titleAlignAnimation,
      required this.buttonAlignAnimation,
      required this.cardVisibilityAnimation,
      required this.cardWidthAnimation,
      required this.cardHeightAnimation,
      required this.cardPaddingAnimation,
      required this.cardContentHeightAnimation,
      required this.duration,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
      child: Stack(
        children: [
          AnimatedBuilder(
              animation: titleAlignAnimation,
              builder: (context, child) {
                return Align(
                  alignment: titleAlignAnimation.value,
                  child: Text(
                    LocaleKeys.kTextItMaySuitYou.tr(),
                    style: UiConstants.kTextStyleHeadline4
                        .copyWith(color: UiConstants.kColorBase05),
                  ),
                );
              }),
          Align(
            alignment: Alignment.center,
            child: BlocBuilder<ItMaySuitCardCubit, ItMaySuitCardState>(
              builder: (context, state) {
                double minWidth = 0;
                double maxWidth = MediaQuery.of(context).size.width;

                if (state is ItMaySuitCardInvisible) {
                  minWidth = MediaQuery.of(context).size.width > 1880
                      ? 783
                      : 783 - (1880 - MediaQuery.of(context).size.width);
                  maxWidth = MediaQuery.of(context).size.width > 1880
                      ? MediaQuery.of(context).size.width
                      : 783 - (1880 - MediaQuery.of(context).size.width);
                }

                return AnimatedContainer(
                  duration: duration,
                  constraints: BoxConstraints(
                      minWidth: minWidth, //1880
                      maxWidth: maxWidth),
                  child: ListView.builder(
                      itemCount: products.length > 4 ? 4 : products.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ItMaySuitCard(
                              product: products[index],
                              visibilityAnimation: cardVisibilityAnimation,
                              imageHeightAnimation: cardHeightAnimation,
                              imageWidthAnimation: cardWidthAnimation,
                              contentHeightAnimation:
                                  cardContentHeightAnimation,
                            ),
                            if (index < 3)
                              AnimatedBuilder(
                                  animation: cardPaddingAnimation,
                                  builder: (context, child) {
                                    return SizedBox(
                                      width: cardPaddingAnimation.value, //16
                                    );
                                  })
                          ],
                        );
                      }),
                );
              },
            ),
          ),
          BlocBuilder<ItMaySuitAnimationCubit, ItMaySuitAnimationState>(
            builder: (context, state) {
              return AnimatedBuilder(
                  animation: buttonAlignAnimation,
                  builder: (context, child) {
                    return Align(
                      alignment: buttonAlignAnimation.value,
                      child: AnimatedSwitcher(
                        duration: duration,
                        child: TomasIconWithTextButton(
                          onPressed: () =>
                              BlocProvider.of<ItMaySuitAnimationCubit>(context)
                                  .onButtonPress(),
                          iconPath: state is ItMaySuitAnimationCollapsed
                              ? Paths.arrowDownIconIconPath
                              : Paths.arrowUpIconIconPath,
                          text: state is ItMaySuitAnimationCollapsed
                              ? LocaleKeys.kTextUnwrap.tr()
                              : LocaleKeys.kTextWrap.tr(),
                          textStyle: UiConstants.kTextStyleHeadline4,
                          textColor: UiConstants.kColorText03,
                          iconWidth: 16,
                          iconHeight: 16,
                          isTrailingIcon: true,
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
