import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/ui/features/cart_screen/components/order_information/components/receiving_method/bloc/receiving_method_event.dart';
part 'receiving_method_state.dart';

class ReceivingMethodBloc
    extends Bloc<ReceivingMethodEvent, ReceivingMethodState> {
  ReceivingMethodBloc() : super(const ReceivingMethodState(isDelivery: true)) {
    on<SwitchMethodEvent>((event, emit) async {
      emit(ReceivingMethodState(isDelivery: event.value));
    });
  }
}
