import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/data_models/review_model.dart';

class ReviewsReviewCard extends StatelessWidget {
  final Review review;

  const ReviewsReviewCard({required this.review, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          top: 40,
          left: 40,
          right: 104,
          bottom: 40,
        ),
        decoration: ShapeDecoration(
          color: UiConstants.kColorBase02,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Container(
                    color: review.profilePhotoColor,
                    padding: const EdgeInsets.only(top: 10, left: 5),
                    child: SvgPicture.asset(
                      review.profilePhoto,
                      height: 90,
                      width: 90,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                Text(
                  review.author,
                  style: UiConstants.kTextStyleButtonMedium
                      .copyWith(height: 0.04, color: UiConstants.kColorText02),
                )
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              review.text,
              style: UiConstants.kTextStyleText2
                  .copyWith(height: 1.3, color: UiConstants.kColorText03),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ));
  }
}
