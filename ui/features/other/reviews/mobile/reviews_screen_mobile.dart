import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/data_models/review_model.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/features/common/footer/mobile/footer_mobile.dart';
import 'package:tomas_matres/ui/features/other/reviews/mobile/components/reviews_review_card_mobile.dart';
import 'package:tomas_matres/ui/features/reviews/cubit/reviews_cubit.dart';
import 'package:tomas_matres/ui/features/template/mobile/mobile_template.dart';

class ReviewsScreenMobile extends StatefulWidget {
  const ReviewsScreenMobile({super.key});

  @override
  State<ReviewsScreenMobile> createState() => _ReviewsScreenMobileState();
}

class _ReviewsScreenMobileState extends State<ReviewsScreenMobile> {
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsLoaded) {
          return MobileTemplate(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: padding,
                child: Text(LocaleKeys.kTextReviews.tr(),
                    style: UiConstants.kTextStyleHeadline5.copyWith(
                      color: UiConstants.kColorText01,
                    )),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: padding,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(state.reviews.length, (index) {
                      final Review item = state.reviews[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: ReviewsReviewCardMobile(
                          review: item,
                        ),
                      );
                    })),
              ),
              const SizedBox(
                height: 80,
              ),
              const FooterMobile()
            ],
          );
        }
        return const TomasLoadIndicator();
      },
    );
  }
}
