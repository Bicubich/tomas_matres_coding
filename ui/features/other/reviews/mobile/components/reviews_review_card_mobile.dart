import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/data_models/review_model.dart';

class ReviewsReviewCardMobile extends StatelessWidget {
  final Review review;

  const ReviewsReviewCardMobile({required this.review, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: 32,
        ),
        decoration: ShapeDecoration(
          color: UiConstants.kColorBase02,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
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
                      height: 56,
                      width: 56,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Text(
                  review.author,
                  style: UiConstants.kTextStyleHeadline3
                      .copyWith(color: UiConstants.kColorText02),
                )
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              review.text,
              style: UiConstants.kTextStyleText3
                  .copyWith(height: 1.5, color: UiConstants.kColorText03),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ));
  }
}
