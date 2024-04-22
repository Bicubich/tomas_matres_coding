import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cart_items_view.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/cart_view/cubit/cart/cart_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/cubit/animation/it_may_suit_animation_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/cubit/card_animation/it_may_suit_card_cubit.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/it_may_suit/it_may_suit_component.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/order_information_view.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/total_price.dart';
import 'package:tomas_matres/ui/features/cart_screen/mobile/cart_screen_mobile.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/recommended_today/recommended_today.dart';
import 'package:tomas_matres/ui/features/common/navigation/navigation_widget.dart';
import 'package:tomas_matres/ui/features/template/template.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context.read<CartCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets mainPadding =
        EdgeInsets.symmetric(horizontal: Utils.calculatePadding(context));
    final EdgeInsets cartMainPadding =
        EdgeInsets.symmetric(horizontal: Utils.calculatePadding(context) + 40);
    final EdgeInsets recommendedTodayPadding = EdgeInsets.symmetric(
        horizontal: Utils.calculatePadding(context) + 40, vertical: 120);

    if (MediaQuery.of(context).size.width < UiConstants.minDesktopWidth) {
      return const CartScreenMobile();
    }

    return PageTemplate(
      body: Expanded(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            children: [
              Padding(
                padding: mainPadding,
                child: const NavigationWidget(),
              ),
              Container(
                color: UiConstants.kColorBase02,
                child: Padding(
                  padding: cartMainPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48.0),
                        child: Text(
                          LocaleKeys.kTextMakingAnOrder.tr(),
                          style: UiConstants.kTextStyleHeadline1
                              .copyWith(color: UiConstants.kColorText01),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(children: [
                              const CartItemsView(),
                              const SizedBox(
                                height: 40,
                              ),
                              MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) =>
                                        ItMaySuitAnimationCubit(),
                                  ),
                                  BlocProvider(
                                    create: (context) => ItMaySuitCardCubit(),
                                  ),
                                ],
                                child: const ItMaySuitComponent(),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const OrderInformationView()
                            ]),
                          ),
                          const SizedBox(
                            width: 88,
                          ),
                          const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(top: 37.0),
                              child: SummaryColumnTotalPrice(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: recommendedTodayPadding,
                child: const RecommendedToday(),
              ),
              Padding(
                padding: mainPadding,
                child: Footer(
                  scrollController: scrollController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
