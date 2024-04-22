import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/ui/components/tomas_notification_widget/tomas_notification_widget_expanded.dart';
import 'package:tomas_matres/ui/components/top_menu_background_shading/background_shading.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/top_menu_favorite_expanded.dart';
import 'package:tomas_matres/ui/features/common/header/header.dart';
import 'package:tomas_matres/ui/features/common/header/search/top_menu_search_expanded.dart';
import 'package:tomas_matres/ui/features/common/header/top_menu/top_menu_collapsed/top_menu.dart';
import 'package:tomas_matres/ui/features/common/header/top_menu/top_menu_expanded/top_menu_expanded.dart';
import 'package:tomas_matres/ui/features/template/template_cubits.dart';

class PageTemplate extends StatelessWidget {
  final Widget body;

  const PageTemplate({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    double mainPadding = Utils.calculatePadding(context);

    return WillPopScope(
      onWillPop: () async {
        bool canPop = Navigator.canPop(context);
        if (canPop) {
          NavigationHelper.removeRoute(context);
        }
        return false;
      },
      child: ScreenUtilInit(
          designSize: const Size(1920, 1080),
          builder: (context, child) => TemplateCubits(
                child: Scaffold(
                  backgroundColor: UiConstants.kColorBase01,
                  body: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Header(),
                          const TopMenu(),
                          body,
                        ],
                      ),
                      const TomasBackgroundShading(),
                      Positioned(
                        top: 171,
                        left: mainPadding,
                        child: const TopMenuExpanded(),
                      ),
                      Positioned(
                        right: mainPadding,
                        top: 91,
                        child: const Column(
                          children: [
                            TopMenuSearchExpanded(),
                            TopMenuFavoriteExpanded(),
                          ],
                        ),
                      ),
                      const Positioned(
                        right: 0,
                        top: 200,
                        child: TomasNotificationWidgetExpanded(),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
