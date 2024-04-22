import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tomas_matres/constants/ui_constants.dart';
import 'package:tomas_matres/ui/features/search_screen/components/search_screen_pagination_number_button.dart';
import 'package:tomas_matres/ui/features/search_screen/cubit/search_screen_cubit.dart';

enum SearchScreenPaginationDirection { forward, reverse }

class SearchScreenPaginationWidget extends StatefulWidget {
  final NumberPaginatorController controller;
  final int activePage;
  final int pageCount;
  final GlobalKey productViewGlobalKey;

  const SearchScreenPaginationWidget(
      {required this.controller,
      required this.activePage,
      required this.pageCount,
      required this.productViewGlobalKey,
      super.key});

  @override
  State<SearchScreenPaginationWidget> createState() =>
      _SearchScreenPaginationWidgetState();
}

class _SearchScreenPaginationWidgetState
    extends State<SearchScreenPaginationWidget> {
  List<int> visibleNumbersIndices = [];
  int countOfMaxVisibleNumbers = 4;

  @override
  void initState() {
    if (widget.pageCount > 6) {
      for (var i = 0; i < widget.pageCount; i++) {
        if (i <= 3) {
          visibleNumbersIndices.add(i);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Container(
            height: 40,
            constraints: const BoxConstraints(maxWidth: 478),
            child: NumberPaginator(
              controller: widget.controller,
              numberPages: widget.pageCount,
              onPageChange: (int index) {
                if (index == widget.activePage - 1) {
                  return;
                }
                SearchScreenPaginationDirection direction;
                if ((index + 1) > (widget.activePage - 1)) {
                  direction = SearchScreenPaginationDirection.forward;
                } else {
                  direction = SearchScreenPaginationDirection.reverse;
                }

                onPageChange(index + 1, direction);
                context
                    .read<SearchScreenCubit>()
                    .onPageSelected(index: index + 1);
              },
              initialPage: widget.activePage - 1,
              contentBuilder: (i) {
                return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.pageCount, (index) {
                      // Если количество страниц меньше или равно 6 то отображаем каждую страницу.
                      if (widget.pageCount <= 6) {
                        return SearchScreenPaginationNumberButton(
                          activePage: widget.activePage,
                          controller: widget.controller,
                          index: index,
                          productViewGlobalKey: widget.productViewGlobalKey,
                        );
                      } else {
                        if (visibleNumbersIndices.isEmpty) {
                          for (var i = 0; i < widget.pageCount; i++) {
                            if (i <= 3) {
                              visibleNumbersIndices.add(i);
                            }
                          }
                        }
                        // Если страниц больше 6.
                        // Если страницы находятся в списке отображаемых, то отображаем их.
                        if (visibleNumbersIndices.contains(index)) {
                          return SearchScreenPaginationNumberButton(
                            activePage: widget.activePage,
                            controller: widget.controller,
                            index: index,
                            productViewGlobalKey: widget.productViewGlobalKey,
                          );
                          // Если это первая страница, то отображаем ее.
                        } else if (index == 0) {
                          return SearchScreenPaginationNumberButton(
                            activePage: widget.activePage,
                            controller: widget.controller,
                            index: index,
                            productViewGlobalKey: widget.productViewGlobalKey,
                          );
                          // Если это место для второй страницы, но первая видимая страница третья или больше,
                          // то отображаем 3 точки.
                        } else if (index == 1 &&
                            visibleNumbersIndices.first >= 2) {
                          return Text(
                            '...',
                            style: UiConstants.kTextStyleText1.copyWith(
                              color: UiConstants.kColorText03,
                            ),
                          );
                          // Если это последняя страница, то отображаем ее.
                        } else if (index == widget.pageCount - 1) {
                          return SearchScreenPaginationNumberButton(
                            activePage: widget.activePage,
                            controller: widget.controller,
                            index: index,
                            productViewGlobalKey: widget.productViewGlobalKey,
                          );
                          // Если это следующая страница после последней видимой то отображаем 3 точки.
                        } else if (index == visibleNumbersIndices.last + 1) {
                          //4
                          return Text(
                            '...',
                            style: UiConstants.kTextStyleText1.copyWith(
                              color: UiConstants.kColorText03,
                            ),
                          );
                          // Во всех остальных случая ничего не показываем
                        } else {
                          return Container();
                        }
                      }
                    }));
              },
              prevButtonBuilder: (context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: TextButton(
                    onPressed: () {
                      if (widget.activePage - 1 >= 1) {
                        widget.controller.prev();
                        if (widget.productViewGlobalKey.currentContext !=
                            null) {
                          Scrollable.ensureVisible(
                              widget.productViewGlobalKey.currentContext!);
                        }
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder?>(
                          const CircleBorder()),
                      overlayColor: MaterialStateProperty.all<Color?>(
                          widget.activePage - 1 >= 1
                              ? UiConstants.kColorBase02
                              : Colors.transparent),
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: UiConstants.kColorBase04,
                    ),
                  ),
                );
              },
              nextButtonBuilder: (context) {
                return TextButton(
                  onPressed: () {
                    if (widget.activePage + 1 <= widget.pageCount) {
                      widget.controller.next();
                      if (widget.productViewGlobalKey.currentContext != null) {
                        Scrollable.ensureVisible(
                            widget.productViewGlobalKey.currentContext!);
                      }
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder?>(
                        const CircleBorder()),
                    overlayColor: MaterialStateProperty.all<Color?>(
                        widget.activePage + 1 <= widget.pageCount
                            ? UiConstants.kColorBase02
                            : Colors.transparent),
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    color: UiConstants.kColorBase04,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // Эта функция меняет список видимых страниц при изменении активной страницы, если необходимо.
  void onPageChange(int activePage, SearchScreenPaginationDirection direction) {
    // Если количество страниц меньше или равно 6 то ничего не делаем
    if (widget.pageCount <= 6) {
      return;
    } else {
      // Если страниц больше 6.
      // Получаем индекс текущей страницы в списке видимых страниц.
      int activePagePositionInVisibleNumbers =
          visibleNumbersIndices.indexOf(activePage - 1);
      if (direction == SearchScreenPaginationDirection.forward) {
        // Если текущая страница последняя из списка видимых и при этом это не предпоследняя страница
        // то сдвигаем все видимые страницы на единицу вперед.
        if (activePagePositionInVisibleNumbers + 1 ==
                countOfMaxVisibleNumbers &&
            visibleNumbersIndices.last != widget.pageCount - 2) {
          visibleNumbersIndices =
              visibleNumbersIndices.map((e) => e + 1).toList();
          // Иначе, если текущая страница последняя и видимые страницы не были сдвинуты,
          // то создаем список видимых страниц заново.
          // Создаем список видимых страниц от последней страницы.
          // Это нужно в случае, если пользователь дошел до последней страницы не последовательно,
          // а нажатием на эту страницу.
        } else if (activePage == widget.pageCount &&
            visibleNumbersIndices.last + 2 != widget.pageCount) {
          visibleNumbersIndices = [];
          for (var i = countOfMaxVisibleNumbers; i > 0; i--) {
            visibleNumbersIndices.add((activePage - 1) - i);
          }
        }
      } else {
        // Если текущая страница первая из списка видимых и при этом
        // это не первая страница то сдвигаем все видимые страницы на единицу назад.
        if (activePagePositionInVisibleNumbers + 1 == 1 &&
            visibleNumbersIndices.first != 0) {
          visibleNumbersIndices =
              visibleNumbersIndices.map((e) => e - 1).toList();
          // Иначе, если текущая страница первая и видимые страницы не были сдвинуты,
          // то создаем список видимых страниц заново.
          // Создаем список видимых страниц от первой страницы.
          // Это нужно в случае, если пользователь дошел до первой страницы не последовательно,
          // а нажатием на эту страницу.
        } else if (activePage == 1 && visibleNumbersIndices.last - 2 != 1) {
          visibleNumbersIndices = [];
          for (var i = 0; i < widget.pageCount; i++) {
            if (i <= 3) {
              visibleNumbersIndices.add(i);
            }
          }
        }
      }
    }
  }
}
