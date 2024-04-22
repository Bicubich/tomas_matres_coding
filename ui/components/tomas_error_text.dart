import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tomas_matres/constants/paths.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/translations/locale_keys.g.dart';
import 'package:tomas_matres/ui/components/tomas_icon_with_text_button.dart';

class TomasErrorText extends StatelessWidget {
  final VoidCallback? onReloadTap;
  const TomasErrorText({this.onReloadTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.kTextErrorOccurred.tr(),
              style: UiConstants.kTextStyleText1,
            ),
            if (onReloadTap != null)
              const SizedBox(
                height: 15,
              ),
            if (onReloadTap != null)
              TomasIconWithTextButton(
                  onPressed: () => onReloadTap!(),
                  iconPath: Paths.reloadIconPath,
                  text: LocaleKeys.kTextReload.tr())
          ],
        ),
      ),
    );
  }
}
