part of 'it_may_suit_animation_cubit.dart';

sealed class ItMaySuitAnimationState extends Equatable {
  const ItMaySuitAnimationState();

  @override
  List<Object> get props => [];
}

final class ItMaySuitAnimationCollapsed extends ItMaySuitAnimationState {}

final class ItMaySuitAnimationExpanded extends ItMaySuitAnimationState {}
