import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/other/about_company/cubit/about_company_cubit.dart';
import 'package:tomas_matres/ui/features/other/about_company/mobile/components/about_company_content_mobile.dart';
import 'package:tomas_matres/ui/features/other/about_company/mobile/components/our_partners_mobile.dart';
import 'package:tomas_matres/ui/features/recommended_today/mobile/recommended_today_mobile.dart';
import 'package:tomas_matres/ui/features/reviews/cubit/reviews_cubit.dart';
import 'package:tomas_matres/ui/features/reviews/mobile/reviews_mobile.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';

class AboutCompanyScreenMobile extends StatefulWidget {
  const AboutCompanyScreenMobile({super.key});

  @override
  State<AboutCompanyScreenMobile> createState() =>
      _AboutCompanyScreenMobileState();
}

class _AboutCompanyScreenMobileState extends State<AboutCompanyScreenMobile> {
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutCompanyCubit, AboutCompanyState>(
      builder: (context, state) {
        if (state is AboutCompanyLoaded) {
          return MobileTemplate(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: padding,
                child: const AboutCompanyContentMobile(),
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: padding,
                child: OurPartnersMobile(partners: state.partners),
              ),
              const RecommendedTodayMobile(),
              BlocBuilder<ReviewsCubit, ReviewsState>(
                builder: (context, state) {
                  if (state is ReviewsLoaded) {
                    return Visibility(
                      visible: state.reviews.isNotEmpty,
                      child: const ReviewsMobile(),
                    );
                  }
                  return const TomasLoadIndicator();
                },
              ),
              const SizedBox(
                height: 80,
              ),
              const FooterMobile(),
            ],
          );
        }
        return const TomasLoadIndicator();
      },
    );
  }
}
