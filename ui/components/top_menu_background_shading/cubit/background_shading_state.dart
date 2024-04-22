part of 'background_shading_cubit.dart';

sealed class BackgroundShadingState extends Equatable {
  final bool roundHeaderBorders;

  const BackgroundShadingState({this.roundHeaderBorders = true});

  @override
  List<Object> get props => [roundHeaderBorders];
}

final class BackgroundShadingActive extends BackgroundShadingState {
  const BackgroundShadingActive({required bool roundHeaderBorders})
      : super(roundHeaderBorders: roundHeaderBorders);

  @override
  List<Object> get props => [roundHeaderBorders];
}

final class BackgroundShadingInactive extends BackgroundShadingState {
  const BackgroundShadingInactive({required bool roundHeaderBorders})
      : super(roundHeaderBorders: roundHeaderBorders);

  @override
  List<Object> get props => [roundHeaderBorders];
}

final class BackgroundShadingHidden extends BackgroundShadingState {}
