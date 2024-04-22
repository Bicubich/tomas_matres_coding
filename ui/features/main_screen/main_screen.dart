import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/shared_cubits/customer/customer_cubit.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/carousel_banner/carousel_banner.dart';
import 'package:tomas_matres/ui/features/carousel_banner/cubit/navigation/carousel_cubit.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/common/header/top_menu/cubit/content/top_menu_content_cubit.dart';
import 'package:tomas_matres/ui/features/products_with_sale/products_with_sale.dart';
import 'package:tomas_matres/ui/features/interior_ideas/interior_ideas.dart';
import 'package:tomas_matres/ui/features/main_screen/cubit/main_screen_cubit.dart';
import 'package:tomas_matres/ui/features/main_screen/mobile/main_screen_mobile.dart';

import 'package:tomas_matres/ui/features/main_screen_cat_tomas_banner/main_screen_cat_tomas_banner.dart';
import 'package:tomas_matres/ui/features/popular_categories/popular_categories.dart';
import 'package:tomas_matres/ui/features/recommended_today/recommended_today.dart';
import 'package:tomas_matres/ui/features/reviews/components/reviews.dart';
import 'package:tomas_matres/ui/features/reviews/cubit/reviews_cubit.dart';
import 'package:tomas_matres/ui/features/template/template.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController scrollController = ScrollController();
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 40);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < UiConstants.minDesktopWidth) {
      return const MainScreenMobile();
    }

    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, customerState) {
        return BlocBuilder<TopMenuContentCubit, TopMenuContentState>(
          builder: (context, topMenuContentState) {
            return BlocBuilder<MainScreenCubit, MainScreenState>(
              builder: (context, mainState) {
                if (mainState is MainScreenLoaded &&
                    topMenuContentState is TopMenuContentLoaded) {
                  return PageTemplate(
                    body: Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: Utils.calculatePadding(context)),
                        controller: scrollController,
                        shrinkWrap: true,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          BlocProvider(
                            create: (context) => CarouselCubit(context),
                            child: Padding(
                              padding: padding,
                              child: const CarouselBanner(),
                            ),
                          ),
                          const SizedBox(
                            height: 120,
                          ),
                          ProductsWithSale(
                            products: mainState.specialProducts,
                          ),
                          const SizedBox(
                            height: 122,
                          ),
                          Padding(
                            padding: padding,
                            child: const RecommendedToday(),
                          ),
                          const SizedBox(
                            height: 160,
                          ),
                          Padding(
                            padding: padding,
                            child: PopularCategories(
                              popularCategories: mainState.popularCategories,
                            ),
                          ),
                          const SizedBox(
                            height: 120,
                          ),
                          const InteriorIdeas(),
                          const SizedBox(height: 77),
                          Padding(
                            padding: padding,
                            child: const MainScreenCatTomasBanner(),
                          ),
                          BlocBuilder<ReviewsCubit, ReviewsState>(
                            builder: (context, state) {
                              if (state is ReviewsLoaded) {
                                return Visibility(
                                  visible: state.reviews.isNotEmpty,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 160),
                                      Padding(
                                        padding: padding,
                                        child: const Reviews(),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return const TomasLoadIndicator();
                            },
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Footer(
                            scrollController: scrollController,
                          )
                        ],
                      ),
                    ),
                  );
                }
                return const TomasLoadIndicator();
              },
            );
          },
        );
      },
    );
  }
}
