import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tomas_notification_widget_state.dart';

class TomasNotificationWidgetCubit extends Cubit<TomasNotificationWidgetState> {
  TomasNotificationWidgetCubit()
      : super(TomasNotificationWidgetCollapsedState(''));

  void expand({required String text}) async {
    if (state is TomasNotificationWidgetExpandedState) {
      final oldText = (state as TomasNotificationWidgetExpandedState).text;
      emit(TomasNotificationWidgetCollapsedState(oldText));
      await Future.delayed(const Duration(milliseconds: 250));
    }
    emit(TomasNotificationWidgetExpandedState(text));
  }

  void collapse() {
    emit(TomasNotificationWidgetCollapsedState(
        (state as TomasNotificationWidgetExpandedState).text));
  }
}
