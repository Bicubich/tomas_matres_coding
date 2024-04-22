import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/api/constants.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/data_models/partner_model.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';

class OurPartnersMobile extends StatefulWidget {
  const OurPartnersMobile({super.key, required this.partners});

  final List<Partner> partners;

  @override
  State<OurPartnersMobile> createState() => _OurPartnersMobileState();
}

class _OurPartnersMobileState extends State<OurPartnersMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.kTextOurPartners.tr(),
          style: UiConstants.kTextStyleHeadline5
              .copyWith(color: UiConstants.kColorText01),
        ),
        const SizedBox(
          height: 32,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 48,
            spacing: 48,
            children: List.generate(
              widget.partners
                  .where(
                      (element) => element.image != null && element.image != '')
                  .length,
              (index) => SizedBox(
                width: 136,
                height: 50,
                child: CachedNetworkImage(
                  imageUrl:
                      '${ApiConstants.imageUrl}${widget.partners[index].image}',
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.bottomCenter,
                  color: UiConstants.kColorBase02,
                  colorBlendMode: BlendMode.modulate,
                  errorWidget: (context, url, error) {
                    return Container(
                      color: UiConstants.kColorBase04,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
