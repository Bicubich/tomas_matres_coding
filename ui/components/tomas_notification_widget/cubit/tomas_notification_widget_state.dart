part of 'tomas_notification_widget_cubit.dart';

class TomasNotificationWidgetState extends Equatable {
  @override
  List<Object> get props => [];
}

final class TomasNotificationWidgetCollapsedState
    extends TomasNotificationWidgetState {
  final String? text;
  TomasNotificationWidgetCollapsedState(
    this.text,
  ) : super();
}

final class TomasNotificationWidgetExpandedState
    extends TomasNotificationWidgetState {
  final String? text;
  TomasNotificationWidgetExpandedState(
    this.text,
  ) : super();
}

final class TomasNotificationWidgetHiddenState
    extends TomasNotificationWidgetState {
  final String? text;
  TomasNotificationWidgetHiddenState(
    this.text,
  ) : super();
}
