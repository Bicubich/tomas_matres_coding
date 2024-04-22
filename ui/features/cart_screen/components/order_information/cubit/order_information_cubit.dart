import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/api/api.dart';
import 'package:tomas_matres/data_models/customer/customer_model.dart';
import 'package:tomas_matres/data_models/zone/zone_model.dart';
import 'package:tomas_matres/shared_cubits/customer/customer_cubit.dart';

part 'order_information_state.dart';

class OrderInformationCubit extends Cubit<OrderInformationState> {
  final CustomerCubit customerCubit;

  OrderInformationCubit({required this.customerCubit})
      : super(OrderInformationLoading()) {
    _init();
  }

  final String countryId = '176'; // Russia
  final String countryName = 'Russian Federation';
  List<Zone> zones = [];
  StreamSubscription<CustomerState>? customerCubitSubscription;

  Future<void> _init() async {
    List<Zone> allZones = await TomasApi.getZones();

    if (allZones.isNotEmpty) {
      zones.addAll(
          allZones.where((element) => element.countryId == countryId).toList());

      zones.sort((a, b) => a.name.compareTo(b.name));

      if (customerCubit.state is CustomerLoaded) {
        emit(OrderInformationLoaded(
            zones: zones,
            customer: customerCubit.isDefault ? null : customerCubit.customer));
      }

      customerCubitSubscription = customerCubit.stream.listen((state) {
        if (state is CustomerLoaded) {
          emit(OrderInformationLoaded(
              zones: zones,
              customer:
                  customerCubit.isDefault ? null : customerCubit.customer));
        }
        if (state is CustomerError) {
          emit(OrderInformationError());
          return;
        }
      });

      return;
    }

    emit(OrderInformationError());
  }

  Future<void> reload() async {
    emit(OrderInformationLoading());
    zones.clear();
    _init();
  }

  @override
  Future<void> close() {
    if (customerCubitSubscription != null) {
      customerCubitSubscription!.cancel();
    }
    return super.close();
  }
}
