import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/features/other/services/components/assembly/components/service_assembly_table.dart';

class ServiceAssembly extends StatelessWidget {
  const ServiceAssembly({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.kTextAssembly.tr(),
            style: UiConstants.kTextStyleHeadline2.copyWith(
              color: UiConstants.kColorText01,
            )),
        const SizedBox(
          height: 56,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: ServiceAssemblyTable()),
            const SizedBox(
              width: 80,
            ),
            Expanded(
              child: Text(
                LocaleKeys.kTextAssemblyInfoContent.tr(),
                style: UiConstants.kTextStyleText1.copyWith(
                  color: UiConstants.kColorText02,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
