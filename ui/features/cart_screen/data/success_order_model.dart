import 'dart:convert';

class SuccessOrder {
  final String orderId;
  final String customerId;
  final String customerGroupId;
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;
  final SuccessOrderPaymentMethod paymentMethod;
  final String shippingAddressId;
  final String shippingFirstname;
  final String shippingLastname;
  final String shippingAddress1;
  final String shippingCity;
  final String shippingCountry;
  final String shippingCountryId;
  final String shippingZone;
  final String shippingZoneId;
  final String comment;
  final String total;
  final String orderStatusId;
  final String affiliateId;
  final String commission;
  final String currencyId;
  final String currencyCode;
  final String ip;
  final String userAgent;
  final String acceptLanguage;
  final DateTime dateAdded;
  final DateTime dateModified;
  final String orderStatus;

  SuccessOrder({
    required this.orderId,
    required this.customerId,
    required this.customerGroupId,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.telephone,
    required this.paymentMethod,
    required this.shippingAddressId,
    required this.shippingFirstname,
    required this.shippingLastname,
    required this.shippingAddress1,
    required this.shippingCity,
    required this.shippingCountry,
    required this.shippingCountryId,
    required this.shippingZone,
    required this.shippingZoneId,
    required this.comment,
    required this.total,
    required this.orderStatusId,
    required this.affiliateId,
    required this.commission,
    required this.currencyId,
    required this.currencyCode,
    required this.ip,
    required this.userAgent,
    required this.acceptLanguage,
    required this.dateAdded,
    required this.dateModified,
    required this.orderStatus,
  });

  SuccessOrder copyWith({
    String? orderId,
    String? customerId,
    String? customerGroupId,
    String? firstname,
    String? lastname,
    String? email,
    String? telephone,
    SuccessOrderPaymentMethod? paymentMethod,
    String? shippingAddressId,
    String? shippingFirstname,
    String? shippingLastname,
    String? shippingAddress1,
    String? shippingCity,
    String? shippingCountry,
    String? shippingCountryId,
    String? shippingZone,
    String? shippingZoneId,
    String? comment,
    String? total,
    String? orderStatusId,
    String? affiliateId,
    String? commission,
    String? currencyId,
    String? currencyCode,
    String? ip,
    String? userAgent,
    String? acceptLanguage,
    DateTime? dateAdded,
    DateTime? dateModified,
    String? orderStatus,
  }) =>
      SuccessOrder(
        orderId: orderId ?? this.orderId,
        customerId: customerId ?? this.customerId,
        customerGroupId: customerGroupId ?? this.customerGroupId,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        telephone: telephone ?? this.telephone,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        shippingAddressId: shippingAddressId ?? this.shippingAddressId,
        shippingFirstname: shippingFirstname ?? this.shippingFirstname,
        shippingLastname: shippingLastname ?? this.shippingLastname,
        shippingAddress1: shippingAddress1 ?? this.shippingAddress1,
        shippingCity: shippingCity ?? this.shippingCity,
        shippingCountry: shippingCountry ?? this.shippingCountry,
        shippingCountryId: shippingCountryId ?? this.shippingCountryId,
        shippingZone: shippingZone ?? this.shippingZone,
        shippingZoneId: shippingZoneId ?? this.shippingZoneId,
        comment: comment ?? this.comment,
        total: total ?? this.total,
        orderStatusId: orderStatusId ?? this.orderStatusId,
        affiliateId: affiliateId ?? this.affiliateId,
        commission: commission ?? this.commission,
        currencyId: currencyId ?? this.currencyId,
        currencyCode: currencyCode ?? this.currencyCode,
        ip: ip ?? this.ip,
        userAgent: userAgent ?? this.userAgent,
        acceptLanguage: acceptLanguage ?? this.acceptLanguage,
        dateAdded: dateAdded ?? this.dateAdded,
        dateModified: dateModified ?? this.dateModified,
        orderStatus: orderStatus ?? this.orderStatus,
      );

  factory SuccessOrder.fromRawJson(String str) =>
      SuccessOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuccessOrder.fromJson(Map<String, dynamic> json) => SuccessOrder(
        orderId: json["order_id"],
        customerId: json["customer_id"],
        customerGroupId: json["customer_group_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        telephone: json["telephone"],
        paymentMethod:
            SuccessOrderPaymentMethod.fromJson(json["payment_method"]),
        shippingAddressId: json["shipping_address_id"],
        shippingFirstname: json["shipping_firstname"],
        shippingLastname: json["shipping_lastname"],
        shippingAddress1: json["shipping_address_1"],
        shippingCity: json["shipping_city"],
        shippingCountry: json["shipping_country"],
        shippingCountryId: json["shipping_country_id"],
        shippingZone: json["shipping_zone"],
        shippingZoneId: json["shipping_zone_id"],
        comment: json["comment"] ?? '',
        total: json["total"],
        orderStatusId: json["order_status_id"],
        affiliateId: json["affiliate_id"],
        commission: json["commission"],
        currencyId: json["currency_id"],
        currencyCode: json["currency_code"],
        ip: json["ip"],
        userAgent: json["user_agent"],
        acceptLanguage: json["accept_language"],
        dateAdded: DateTime.parse(json["date_added"]),
        dateModified: DateTime.parse(json["date_modified"]),
        orderStatus: json["order_status"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer_id": customerId,
        "customer_group_id": customerGroupId,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "telephone": telephone,
        "payment_method": paymentMethod.toJson(),
        "shipping_address_id": shippingAddressId,
        "shipping_firstname": shippingFirstname,
        "shipping_lastname": shippingLastname,
        "shipping_address_1": shippingAddress1,
        "shipping_city": shippingCity,
        "shipping_country": shippingCountry,
        "shipping_country_id": shippingCountryId,
        "shipping_zone": shippingZone,
        "shipping_zone_id": shippingZoneId,
        "comment": comment,
        "total": total,
        "order_status_id": orderStatusId,
        "affiliate_id": affiliateId,
        "commission": commission,
        "currency_id": currencyId,
        "currency_code": currencyCode,
        "ip": ip,
        "user_agent": userAgent,
        "accept_language": acceptLanguage,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "order_status": orderStatus,
      };
}

class SuccessOrderPaymentMethod {
  final String name;

  SuccessOrderPaymentMethod({
    required this.name,
  });

  SuccessOrderPaymentMethod copyWith({
    String? name,
  }) =>
      SuccessOrderPaymentMethod(
        name: name ?? this.name,
      );

  factory SuccessOrderPaymentMethod.fromRawJson(String str) =>
      SuccessOrderPaymentMethod.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuccessOrderPaymentMethod.fromJson(Map<String, dynamic> json) =>
      SuccessOrderPaymentMethod(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
