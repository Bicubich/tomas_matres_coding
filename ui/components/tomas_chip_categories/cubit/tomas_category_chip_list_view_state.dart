part of 'tomas_category_chip_list_view_cubit.dart';

class TomasCategoryChipListViewState extends Equatable {
  final int activeIndex;
  const TomasCategoryChipListViewState({required this.activeIndex});

  @override
  List<Object> get props => [activeIndex];
}
