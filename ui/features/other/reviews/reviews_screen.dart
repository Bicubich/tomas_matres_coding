import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/data_models/review_model.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/common/footer/data/footer_data.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/common/navigation/navigation_widget.dart';
import 'package:tomas_matres/ui/features/other/reviews/components/reviews_review_card.dart';
import 'package:tomas_matres/ui/features/other/reviews/mobile/reviews_screen_mobile.dart';
import 'package:tomas_matres/ui/features/reviews/cubit/reviews_cubit.dart';
import 'package:tomas_matres/ui/features/template/template.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final ScrollController scrollController = ScrollController();
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 40);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < UiConstants.minDesktopWidth) {
      return const ReviewsScreenMobile();
    }

    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsLoaded) {
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
                    child: Text(LocaleKeys.kTextReviews.tr(),
                        style: UiConstants.kTextStyleHeadline1.copyWith(
                          color: UiConstants.kColorText01,
                        )),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Padding(
                    padding: padding,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 612),
                          constraints: const BoxConstraints(maxWidth: 1060),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children:
                                  List.generate(state.reviews.length, (index) {
                                final Review item = state.reviews[index];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 32),
                                  child: ReviewsReviewCard(
                                    review: item,
                                  ),
                                );
                              })),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            width: 592,
                            child: RichText(
                              text: TextSpan(
                                  text:
                                      LocaleKeys.kTextReviewsScreenContent.tr(),
                                  style: UiConstants.kTextStyleText1.copyWith(
                                    color: UiConstants.kColorText02,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: FooterData.email,
                                      style: UiConstants.kTextStyleText1
                                          .copyWith(
                                              color: UiConstants.kColorText02,
                                              fontWeight: FontWeight.w700),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async =>
                                            await Utils.copyToClipboard(
                                              context,
                                              FooterData.email,
                                            ),
                                    ),
                                  ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 120,
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
