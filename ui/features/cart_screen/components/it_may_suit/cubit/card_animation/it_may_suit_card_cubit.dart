import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'it_may_suit_card_state.dart';

class ItMaySuitCardCubit extends Cubit<ItMaySuitCardState> {
  ItMaySuitCardCubit() : super(ItMaySuitCardInvisible());

  void show() => emit(ItMaySuitCardVisible());

  void hide() => emit(ItMaySuitCardInvisible());
}
