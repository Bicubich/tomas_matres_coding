part of 'it_may_suit_card_cubit.dart';

sealed class ItMaySuitCardState extends Equatable {
  const ItMaySuitCardState();

  @override
  List<Object> get props => [];
}

final class ItMaySuitCardInvisible extends ItMaySuitCardState {}

final class ItMaySuitCardVisible extends ItMaySuitCardState {}
