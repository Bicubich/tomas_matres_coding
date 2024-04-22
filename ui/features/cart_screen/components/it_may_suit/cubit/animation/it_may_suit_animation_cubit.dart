import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'it_may_suit_animation_state.dart';

class ItMaySuitAnimationCubit extends Cubit<ItMaySuitAnimationState> {
  ItMaySuitAnimationCubit() : super(ItMaySuitAnimationCollapsed());

  void onButtonPress() {
    if (state is ItMaySuitAnimationCollapsed) {
      expand();
      return;
    }

    if (state is ItMaySuitAnimationExpanded) {
      collapse();
      return;
    }
  }

  void expand() => emit(ItMaySuitAnimationExpanded());

  void collapse() => emit(ItMaySuitAnimationCollapsed());
}
