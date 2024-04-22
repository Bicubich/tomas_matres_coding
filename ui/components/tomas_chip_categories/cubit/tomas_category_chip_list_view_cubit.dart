import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tomas_category_chip_list_view_state.dart';

class TomasCategoryChipListViewCubit
    extends Cubit<TomasCategoryChipListViewState> {
  TomasCategoryChipListViewCubit()
      : super(const TomasCategoryChipListViewState(activeIndex: 0));

  void onChipTap({required int index}) =>
      emit(TomasCategoryChipListViewState(activeIndex: index));
}
