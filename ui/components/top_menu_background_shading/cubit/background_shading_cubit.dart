import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'background_shading_state.dart';

class BackgroundShadingCubit extends Cubit<BackgroundShadingState> {
  BackgroundShadingCubit() : super(BackgroundShadingHidden());

  void activate({bool roundHeaderBorders = true}) {
    emit(BackgroundShadingActive(roundHeaderBorders: roundHeaderBorders));
  }

  void deactivate({bool roundHeaderBorders = true}) {
    emit(BackgroundShadingInactive(roundHeaderBorders: roundHeaderBorders));
  }

  void hide() {
    emit(BackgroundShadingHidden());
  }
}
