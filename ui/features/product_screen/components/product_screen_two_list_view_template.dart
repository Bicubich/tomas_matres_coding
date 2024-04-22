import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/tomas_load_indicator.dart';
import 'package:tomas_matres/ui/components/tomas_notification_widget/tomas_notification_widget_expanded.dart';
import 'package:tomas_matres/ui/components/top_menu_background_shading/background_shading.dart';
import 'package:tomas_matres/ui/features/common/footer/footer.dart';
import 'package:tomas_matres/ui/features/common/header/favorite/top_menu_favorite_expanded.dart';
import 'package:tomas_matres/ui/features/common/header/header.dart';
import 'package:tomas_matres/ui/features/common/header/search/top_menu_search_expanded.dart';
import 'package:tomas_matres/ui/features/common/header/top_menu/top_menu_collapsed/top_menu.dart';
import 'package:tomas_matres/ui/features/common/header/top_menu/top_menu_expanded/top_menu_expanded.dart';
import 'package:tomas_matres/ui/features/common/navigation/navigation_widget.dart';
import 'package:tomas_matres/ui/features/product_screen/components/product_info.dart';
import 'package:tomas_matres/ui/features/template/template_cubits.dart';

class ProductScreenTwoListViewPageTemplate extends StatefulWidget {
  final List<Widget> leftColumnWidgets;
  final Product product;
  final List<Widget> bottomWidgets;
  final bool loading;
  final int leftColumnFlex;
  final int rightColumnFlex;
  final double spaceBtwLeftAndRightColumns;
  final String routePath;

  const ProductScreenTwoListViewPageTemplate(
      {required this.leftColumnWidgets,
      required this.product,
      this.leftColumnFlex = 1,
      this.rightColumnFlex = 1,
      this.bottomWidgets = const [],
      this.loading = false,
      this.spaceBtwLeftAndRightColumns = 32,
      required this.routePath,
      super.key});

  @override
  State<ProductScreenTwoListViewPageTemplate> createState() =>
      _ProductScreenTwoListViewPageTemplateState();
}

class _ProductScreenTwoListViewPageTemplateState
    extends State<ProductScreenTwoListViewPageTemplate> {
  final ScrollController mainScrollController = ScrollController();
  final ScrollController leftColumnScrollController = ScrollController();
  final ScrollController rightColumnScrollController = ScrollController();
  final List<Widget> bottomWidgetsWithFooter = [];

  @override
  void initState() {
    bottomWidgetsWithFooter.addAll(widget.bottomWidgets);
    bottomWidgetsWithFooter.addAll([
      const SizedBox(
        height: 40,
      ),
      Footer(
        scrollController: mainScrollController,
        footerOnTopTap: footerOnTopTap,
      )
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainPadding = Utils.calculatePadding(context);
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      child: TemplateCubits(
        child: Scaffold(
          backgroundColor: UiConstants.kColorBase01,
          body: widget.loading
              ? const SizedBox(height: 400, child: TomasLoadIndicator())
              : Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Header(),
                        const TopMenu(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Utils.calculatePadding(context)),
                          height: MediaQuery.of(context).size.height -
                              171,
                          child: Listener(
                            onPointerSignal: (PointerSignalEvent event) =>
                                onMainPointerSignal(event),
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              cacheExtent: 5000,
                              controller: mainScrollController,
                              children: [
                                NavigationWidget(
                                  customRoute: CustomRoute(
                                      title: widget.product.name,
                                      path: widget.routePath),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // LEFT COLUMN
                                    Expanded(
                                      flex: widget.leftColumnFlex,
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                171),
                                        child: Listener(
                                          onPointerSignal: (PointerSignalEvent
                                                  event) =>
                                              onPointerSignal(
                                                  event,
                                                  leftColumnScrollController,
                                                  rightColumnScrollController),
                                          child: ScrollConfiguration(
                                            behavior:
                                                ScrollConfiguration.of(context)
                                                    .copyWith(
                                                        scrollbars: false),
                                            child: ListView(
                                              controller:
                                                  leftColumnScrollController,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              children:
                                                  widget.leftColumnWidgets,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widget.spaceBtwLeftAndRightColumns,
                                    ),
                                    // RIGHT COLUMN
                                    Expanded(
                                      flex: widget.rightColumnFlex,
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                171),
                                        child: Listener(
                                          onPointerSignal: (PointerSignalEvent
                                                  event) =>
                                              onPointerSignal(
                                                  event,
                                                  rightColumnScrollController,
                                                  leftColumnScrollController),
                                          child: ScrollConfiguration(
                                            behavior:
                                                ScrollConfiguration.of(context)
                                                    .copyWith(
                                                        scrollbars: false),
                                            child: ListView(
                                              controller:
                                                  rightColumnScrollController,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 40),
                                                  child: ProductInfo(
                                                    product: widget.product,
                                                    scrollController:
                                                        rightColumnScrollController,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                ...bottomWidgetsWithFooter
                              ],
                            ),
                          ),
                        )
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
                        )),
                    const Positioned(
                      right: 0,
                      top: 200,
                      child: TomasNotificationWidgetExpanded(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void onPointerSignal(PointerSignalEvent event, ScrollController domController,
      ScrollController subController) {
    if (event is PointerScrollEvent) {
      // Check direction
      if (event.scrollDelta.dy > 0) {
        // Check if mainListView is in max scroll extent
        if (domController.offset == domController.position.maxScrollExtent) {
          //Check is subListView is not in max scroll extent
          if (subController.offset != subController.position.maxScrollExtent) {
            scrollListView(subController, event.scrollDelta.dy);
          } else {
            scrollListView(mainScrollController, event.scrollDelta.dy);
          }
        } else {
          // DOM LISTVIEW DOWN
          scrollListView(domController, event.scrollDelta.dy);
        }

        return;
      }
      if (event.scrollDelta.dy < 0) {
        if (mainScrollController.offset !=
            mainScrollController.position.minScrollExtent) {
          scrollListView(mainScrollController, event.scrollDelta.dy);
        } else {
          // Check if mainListView is in min scroll extent
          if (domController.offset == domController.position.minScrollExtent) {
            //Check is subListView is not in min scroll extent
            if (subController.offset !=
                subController.position.minScrollExtent) {
              scrollListView(subController, event.scrollDelta.dy);
            }
          } else {
            // DOM LISTVIEW UP
            scrollListView(domController, event.scrollDelta.dy);
          }
        }
      }
    }
  }

  void onMainPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      if (event.scrollDelta.dy > 0) {
        if (leftColumnScrollController.hasClients &&
            rightColumnScrollController.hasClients) {
          if (leftColumnScrollController.offset ==
                  leftColumnScrollController.position.maxScrollExtent &&
              rightColumnScrollController.offset ==
                  rightColumnScrollController.position.maxScrollExtent) {
            scrollListView(mainScrollController, event.scrollDelta.dy);
          }
        } else {
          scrollListView(mainScrollController, event.scrollDelta.dy);
        }

        return;
      }

      if (event.scrollDelta.dy < 0) {
        if (leftColumnScrollController.hasClients &&
            rightColumnScrollController.hasClients) {
          if (mainScrollController.offset !=
              mainScrollController.position.minScrollExtent) {
            scrollListView(mainScrollController, event.scrollDelta.dy);
          }
        } else {
          scrollListView(mainScrollController, event.scrollDelta.dy);
        }
      }
    }
  }

  void scrollListView(ScrollController scrollController, double scrollDelta) {
    double jumpTo = scrollController.offset + scrollDelta;

    if (jumpTo < scrollController.position.minScrollExtent) {
      jumpTo = scrollController.position.minScrollExtent;
    } else if (jumpTo > scrollController.position.maxScrollExtent) {
      jumpTo = scrollController.position.maxScrollExtent;
    }

    scrollController.jumpTo(jumpTo);
  }

  footerOnTopTap() {
    leftColumnScrollController.jumpTo(0);
    rightColumnScrollController.jumpTo(0);
  }
}
