import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/shared_cubits/customer/customer_cubit.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/carousel_banner/cubit/navigation/carousel_cubit.dart';
import 'package:tomas_matres/ui/features/carousel_banner/mobile/carousel_banner_mobile.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/products_with_sale/mobile/products_with_sale_mobile.dart';
import 'package:tomas_matres/ui/features/interior_ideas/mobile/interior_ideas_mobile.dart';
import 'package:tomas_matres/ui/features/main_screen/cubit/main_screen_cubit.dart';
import 'package:tomas_matres/ui/features/main_screen_cat_tomas_banner/mobile/main_screen_cat_tomas_banner_mobile.dart';
import 'package:tomas_matres/ui/features/popular_categories/mobile/popular_categories_mobile.dart';
import 'package:tomas_matres/ui/features/recommended_today/mobile/recommended_today_mobile.dart';
import 'package:tomas_matres/ui/features/reviews/mobile/reviews_mobile.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';

class MainScreenMobile extends StatelessWidget {
  const MainScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, customerState) {
        return BlocBuilder<MainScreenCubit, MainScreenState>(
          builder: (context, state) {
            if (state is MainScreenLoaded) {
              return MobileTemplate(children: [
                const SizedBox(
                  height: 12,
                ),
                BlocProvider(
                  create: (context) => CarouselCubit(context),
                  child: const CarouselBannerMobile(),
                ),
                const SizedBox(
                  height: 56,
                ),
                ProductsWithSaleMobile(
                  products: state.specialProducts,
                ),
                const SizedBox(
                  height: 80,
                ),
                const RecommendedTodayMobile(),
                const SizedBox(
                  height: 80,
                ),
                PopularCategoriesMobile(
                  popularCategories: state.popularCategories,
                ),
                const SizedBox(
                  height: 56,
                ),
                const InteriorIdeasMobile(),
                const MainScreenCatTomasBannerMobile(),
                const ReviewsMobile(),
                const SizedBox(
                  height: 80,
                ),
                const FooterMobile()
              ]);
            }
            return const TomasLoadIndicator();
          },
        );
      },
    );
  }
}
