import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/info_dropdown/bloc/total_dropdown_item_event.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/summary_column/info_dropdown/bloc/total_dropdown_item_state.dart';

class TotalPriceBloc extends Bloc<TotalPriceEvent, TotalPriceState> {
  TotalPriceBloc() : super(const TotalPriceState(isDropdownVisible: false)) {
    on<ToggleDropdownEvent>((event, emit) async {
      emit(TotalPriceState(isDropdownVisible: !state.isDropdownVisible));
    });
  }
}
