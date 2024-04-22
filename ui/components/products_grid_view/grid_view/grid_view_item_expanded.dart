// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/constants/utils.dart';
import 'package:tomas_matres/system/data/route_model.dart';
import 'package:tomas_matres/system/navigation/navigation_helper.dart';
import 'package:tomas_matres/system/navigation/routes.dart';
import 'package:tomas_matres/ui/components/products_grid_view/bloc/product_grid_view_item_bloc.dart';
import 'package:tomas_matres/ui/components/products_grid_view/card/products_list_card_expanded.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/functions/products_grid_view_functions.dart';
import 'dart:html' as html;

class GridViewItemExpanded extends StatefulWidget {
  final int index;
  final Product product;
  final int countOfElementsPerRow;
  final int maxCountOfElementsPerRow;

  const GridViewItemExpanded(
      {required this.index,
      required this.product,
      required this.countOfElementsPerRow,
      required this.maxCountOfElementsPerRow,
      super.key});

  @override
  State<GridViewItemExpanded> createState() => _GridViewItemExpandedState();
}

class _GridViewItemExpandedState extends State<GridViewItemExpanded> {
  final Duration duration = const Duration(milliseconds: 127);

  @override
  void initState() {
    super.initState();
    // Prevent default event handler
    html.document.onContextMenu.listen((event) => event.preventDefault());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductGridViewItemBloc, ProductGridViewItemState>(
      builder: (context, state) {
        bool expanded =
            state is ProductGridViewItemExpandedState && state.selected;

        double? top = ProductsGridViewFunctions.getTopPosition(
            index: widget.index,
            countOfElementsPerRow: widget.countOfElementsPerRow);
        double? left = ProductsGridViewFunctions.getLeftPosition(
          context: context,
          index: widget.index,
          countOfElementsPerRow: widget.countOfElementsPerRow,
          maxCountOfElementsPerRow: widget.maxCountOfElementsPerRow,
        );
        double? right = ProductsGridViewFunctions.getRightPosition(
          context: context,
          index: widget.index,
          countOfElementsPerRow: widget.countOfElementsPerRow,
          maxCountOfElementsPerRow: widget.maxCountOfElementsPerRow,
        );

        if (top != null) {
          top = top - (expanded ? 24 : 0);
        }
        if (left != null) {
          left = left - (expanded ? 24 : 0);
        }
        if (right != null) {
          right = right - (expanded ? 24 : 0);
        }

        return AnimatedPositioned(
          top: top,
          left: left,
          right: right,
          duration: duration,
          curve: Curves.easeInOut,
          child: Visibility(
            visible: state is ProductGridViewItemExpandedState,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (event) => onHover(context),
              onExit: (event) => onExit(context),
              child: Listener(
                onPointerDown: (event) => Utils.onPointerDown(context, event,
                    '${Routes.productScreen.path}&id=${widget.product.id}'),
                child: GestureDetector(
                  onTap: () => NavigationHelper.addRoute(
                      context,
                      CustomRoute(
                          title: widget.product.name,
                          path:
                              '${Routes.productScreen.path}&id=${widget.product.id}')),
                  child: AnimatedContainer(
                    width: ProductsGridViewFunctions.reSize(
                          context: context,
                          maxCountOfElementsPerRow:
                              widget.maxCountOfElementsPerRow,
                        ) +
                        (expanded ? 48 : 0),
                    constraints: BoxConstraints(
                      minHeight: expanded ? 560.0 : 408.0,
                      maxHeight: expanded ? 584.0 : 408.0,
                    ),
                    padding: expanded
                        ? const EdgeInsets.only(
                            top: 24, left: 24, right: 24, bottom: 40)
                        : const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: UiConstants.kColorBase01,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: expanded
                              ? Colors.grey
                              : Colors.white, // Цвет тени
                          offset: Offset(
                              0,
                              expanded
                                  ? 3
                                  : 0), // Смещение тени (горизонтальное, вертикальное)
                          blurRadius: expanded ? 6 : 0, // Радиус размытия тени
                          spreadRadius: 0,
                        ) // Радиус распространения тени (0 - тень равномерная)
                      ],
                    ),
                    duration: duration,
                    curve: Curves.easeInOut,
                    transformAlignment: Alignment.center,
                    onEnd: () => onAnimationEnd(context, expanded),
                    child: state is ProductGridViewItemExpandedState
                        ? ProductsListCardExpanded(
                            product: widget.product,
                          )
                        : Container(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onExit(BuildContext context) async {
    BlocProvider.of<ProductGridViewItemBloc>(context)
        .add(ProductGridViewItemStartBackwardAnimationEvent());

    await Future.delayed(duration + const Duration(milliseconds: 10), () {
      ProductGridViewItemState state =
          BlocProvider.of<ProductGridViewItemBloc>(context).state;
      if (state is ProductGridViewItemExpandedState &&
          state.selected == false) {
        BlocProvider.of<ProductGridViewItemBloc>(context)
            .add(ProductGridViewItemShowCollapsedEvent());
      }
    });
  }

  void onHover(BuildContext context) {
    BlocProvider.of<ProductGridViewItemBloc>(context)
        .add(ProductGridViewItemStartForwardAnimationEvent());
  }

  void onAnimationEnd(BuildContext context, bool expanded) {
    if (!expanded) {
      BlocProvider.of<ProductGridViewItemBloc>(context)
          .add(ProductGridViewItemShowCollapsedEvent());
    }
  }
}
