import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/common/navigation/navigation_widget.dart';
import 'package:tomas_matres/ui/features/other/about_company/components/about_company_content.dart';
import 'package:tomas_matres/ui/features/other/about_company/components/our_partners.dart';
import 'package:tomas_matres/ui/features/other/about_company/cubit/about_company_cubit.dart';
import 'package:tomas_matres/ui/features/other/about_company/mobile/about_company_screen_mobile.dart';
import 'package:tomas_matres/ui/features/reviews/components/reviews.dart';
import 'package:tomas_matres/ui/features/reviews/cubit/reviews_cubit.dart';
import 'package:tomas_matres/ui/features/template/template.dart';

class AboutCompanyScreen extends StatefulWidget {
  const AboutCompanyScreen({super.key});

  @override
  State<AboutCompanyScreen> createState() => _AboutCompanyScreenState();
}

class _AboutCompanyScreenState extends State<AboutCompanyScreen> {
  final ScrollController scrollController = ScrollController();
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 40);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < UiConstants.minDesktopWidth) {
      return const AboutCompanyScreenMobile();
    }
    return BlocBuilder<AboutCompanyCubit, AboutCompanyState>(
      builder: (context, state) {
        if (state is AboutCompanyLoaded) {
          return PageTemplate(
            body: Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: Utils.calculatePadding(context)),
                controller: scrollController,
                shrinkWrap: true,
                children: [
                  const NavigationWidget(),
                  Padding(
                    padding: padding,
                    child: const AboutCompanyContent(),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  Padding(
                    padding: padding,
                    child: OurPartners(partners: state.partners),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  BlocBuilder<ReviewsCubit, ReviewsState>(
                    builder: (context, state) {
                      if (state is ReviewsLoaded) {
                        return Visibility(
                          visible: state.reviews.isNotEmpty,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 120,
                              ),
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
  }
}
