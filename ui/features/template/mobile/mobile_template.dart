import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/components/tomas_notification_widget/mobile/tomas_notification_widget_expanded_mobile.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/mobile/top_menu_favorite_expanded_mobile.dart';
import 'package:tomas_matres/ui/features/common/header/mobile/components/top_menu_expanded_mobile/top_menu_expanded_mobile.dart';
import 'package:tomas_matres/ui/features/common/header/mobile/components/top_menu_search_expanded_mobile.dart';
import 'package:tomas_matres/ui/features/common/header/mobile/header_mobile.dart';
import 'package:tomas_matres/ui/features/common/header/search/cubit/top_menu_search_cubit.dart';
import 'package:tomas_matres/ui/features/common/header/top_menu/top_menu_expanded/cubit/animation/top_menu_expanded_animation_cubit.dart';
import 'package:tomas_matres/ui/features/template/template_cubits.dart';

class MobileTemplate extends StatefulWidget {
  final List<Widget> children;

  const MobileTemplate({required this.children, super.key});

  @override
  State<MobileTemplate> createState() => _MobileTemplateState();
}

class _MobileTemplateState extends State<MobileTemplate> {
  final ScrollController scrollController = ScrollController();
  final GlobalKey headerKey = GlobalKey();

  late final HeaderMobile headerDelegate;

  @override
  void initState() {
    headerDelegate = HeaderMobile(expandedHeight: 104);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 211),
        builder: (context, child) => TemplateCubits(
              child: Scaffold(
                  backgroundColor: UiConstants.kColorBase01,
                  body: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      BlocBuilder<TopMenuExpandedAnimationCubit,
                          TopMenuExpandedAnimationState>(
                        builder: (context, topMenuExpandedAnimationState) {
                          return BlocBuilder<TopMenuSearchCubit,
                              TopMenuSearchState>(
                            builder: (context, topMenuSearchState) {
                              return CustomScrollView(
                                controller: scrollController,
                                cacheExtent: 7000,
                                physics: isSearchExpanded(topMenuSearchState) ||
                                        isTopMenuExpanded(
                                            topMenuExpandedAnimationState)
                                    ? const NeverScrollableScrollPhysics()
                                    : const AlwaysScrollableScrollPhysics(),
                                slivers: [
                                  SliverPersistentHeader(
                                    key: headerKey,
                                    delegate: headerDelegate,
                                    pinned: true,
                                  ),
                                  SliverList(
                                      delegate: SliverChildListDelegate(
                                    widget.children,
                                  ))
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const Positioned(
                        right: 0,
                        child: TopMenuFavoriteExpandedMobile(),
                      ),
                      TopMenuExpandedMobile(
                        headerGlobalKey: headerKey,
                        headerMobile: headerDelegate,
                      ),
                      TopMenuSearchExpandedMobile(
                        headerGlobalKey: headerKey,
                        headerMobile: headerDelegate,
                      ),
                      const Positioned(
                          top: 26,
                          child: TomasNotificationWidgetExpandedMobile())
                    ],
                  )),
            ));
  }

  bool isSearchExpanded(TopMenuSearchState topMenuSearchState) {
    return topMenuSearchState is TopMenuSearchExpandedState ||
        topMenuSearchState is TopMenuSearchLoadingState;
  }

  bool isTopMenuExpanded(
      TopMenuExpandedAnimationState topMenuExpandedAnimationState) {
    return topMenuExpandedAnimationState is TopMenuExpandedAnimationExpanded;
  }
}
