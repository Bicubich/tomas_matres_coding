// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/api/api.dart';
import 'package:tomas_matres/data_models/customer/customer_model.dart';
import 'package:tomas_matres/data_models/customer/default_customer_model.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerLoading()) {
    _init();
  }

  String? customerId;
  late Customer customer;
  bool isDefault = true;

  Future<void> _init() async {
    final String? cookie = document.cookie;

    if (cookie != null && cookie.isNotEmpty) {
      final Iterable<MapEntry<String, String>> entity =
          cookie.split("; ").map((item) {
        final split = item.split("=");
        return MapEntry(split[0], split[1]);
      });
      if (entity.isNotEmpty) {
        final Map<String, String> cookieMap = Map.fromEntries(entity);

        if (cookieMap.containsKey('customer_id')) {
          customerId = cookieMap['customer_id'] ?? '';

          customer = await TomasApi.getCustomerById(customerId!);

          DefaultCustomer defaultCustomer =
              DefaultCustomer(email: "test@test.ru");

          isDefault = (customer.firstname == defaultCustomer.firstname &&
              customer.lastname == defaultCustomer.lastname);

          emit(CustomerLoaded());

          return;
        }
      }
    }
    DefaultCustomer defaultCustomer = await TomasApi.registerCustomer();

    customer = await TomasApi.getCustomerByMail(defaultCustomer);
    customerId = customer.customerId;
    document.cookie = "customer_id=${customer.customerId}";

    isDefault = true;

    emit(CustomerLoaded());
  }

  Future<void> edit(
      {String? firstname,
      String? lastname,
      String? email,
      String? phone}) async {
    customer = customer.copyWith(
      firstname: firstname,
      lastname: lastname,
      email: email,
      telephone: phone,
    );
    emit(CustomerLoading());

    await TomasApi.editCustomer(customer);

    isDefault = false;

    emit(CustomerLoaded());
  }
}
