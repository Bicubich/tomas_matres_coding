import 'dart:convert';

import 'package:tomas_matres/data_models/customer/customer_model.dart';
import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';
import 'package:tomas_matres/ui/features/cart_screen/data/cart_product_model.dart';

class Order {
  final Customer customer;
  final Address paymentAddress;
  final PaymentMethod paymentMethod;
  final Address shippingAddress;
  final List<OrderProduct> products;
  final String comment;
  final double total;
  final int affiliateId;
  final List<OrderTotal> totals;

  Order({
    required this.customer,
    required this.paymentAddress,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.products,
    required this.comment,
    required this.total,
    this.affiliateId = 0,
    required this.totals,
  });

  Order copyWith({
    Customer? customer,
    Address? paymentAddress,
    PaymentMethod? paymentMethod,
    Address? shippingAddress,
    List<OrderProduct>? products,
    String? comment,
    double? total,
    int? affiliateId,
    List<OrderTotal>? totals,
  }) =>
      Order(
        customer: customer ?? this.customer,
        paymentAddress: paymentAddress ?? this.paymentAddress,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        products: products ?? this.products,
        comment: comment ?? this.comment,
        total: total ?? this.total,
        affiliateId: affiliateId ?? this.affiliateId,
        totals: totals ?? this.totals,
      );

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      customer: Customer.fromJson(json["customer"]),
      paymentAddress: Address.fromJson(json["payment_address"]),
      paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
      shippingAddress: Address.fromJson(json["shipping_address"]),
      products: List<OrderProduct>.from(
          json["products"].map((x) => OrderProduct.fromJson(x))),
      comment: json["comment"],
      total: json["total"],
      affiliateId: json["affiliate_id"],
      totals: List<OrderTotal>.from(
          json["totals"].map((x) => OrderTotal.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
        "payment_address": paymentAddress.toJson(),
        "payment_method": paymentMethod.toJson(),
        "shipping_address": shippingAddress.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "comment": comment,
        "total": total,
        "affiliate_id": affiliateId,
        "totals": List<dynamic>.from(totals.map((x) => x.toJson())),
      };
}

class Address {
  final String firstname;
  final String lastname;
  final String address1;
  final String city;
  final String zone;
  final String zoneId;
  final String country;
  final String countryId;
  final String title;
  final String code;

  Address({
    required this.firstname,
    required this.lastname,
    required this.address1,
    required this.city,
    required this.zone,
    required this.zoneId,
    required this.country,
    required this.countryId,
    this.title = 'Cash On Delivery',
    this.code = 'cod',
  });

  Address copyWith({
    String? firstname,
    String? lastname,
    String? address1,
    String? city,
    String? zone,
    String? zoneId,
    String? country,
    String? countryId,
    String? title,
    String? code,
  }) =>
      Address(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        address1: address1 ?? this.address1,
        city: city ?? this.city,
        zone: zone ?? this.zone,
        zoneId: zoneId ?? this.zoneId,
        country: country ?? this.country,
        countryId: countryId ?? this.countryId,
        title: title ?? this.title,
        code: code ?? this.code,
      );

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        firstname: json["firstname"],
        lastname: json["lastname"],
        address1: json["address_1"],
        city: json["city"],
        zone: json["zone"],
        zoneId: json["zone_id"],
        country: json["country"],
        countryId: json["country_id"],
        title: json["title"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "address_1": address1,
        "city": city,
        "zone": zone,
        "zone_id": zoneId,
        "country": country,
        "country_id": countryId,
        "title": title,
        "code": code,
      };
}

class PaymentMethod {
  final String title;
  final String code;

  PaymentMethod({
    this.title = 'Cash On Delivery',
    this.code = 'cod',
  });

  PaymentMethod copyWith({
    String? title,
    String? code,
  }) =>
      PaymentMethod(
        title: title ?? this.title,
        code: code ?? this.code,
      );

  factory PaymentMethod.fromRawJson(String str) =>
      PaymentMethod.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        title: json["title"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "code": code,
      };
}

class OrderProduct {
  final String productId;
  final String name;
  final String model;
  final int quantity;
  final String price;
  final int total;
  final String taxClassId;
  final int subtract;
  final List<OrderOption> option;

  OrderProduct({
    required this.productId,
    required this.name,
    required this.model,
    required this.quantity,
    required this.price,
    required this.total,
    required this.taxClassId,
    this.subtract = 0,
    required this.option,
  });

  OrderProduct copyWith({
    String? productId,
    String? name,
    String? model,
    int? quantity,
    String? price,
    int? total,
    String? taxClassId,
    int? subtract,
    List<OrderOption>? option,
  }) =>
      OrderProduct(
        productId: productId ?? this.productId,
        name: name ?? this.name,
        model: model ?? this.model,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        total: total ?? this.total,
        taxClassId: taxClassId ?? this.taxClassId,
        subtract: subtract ?? this.subtract,
        option: option ?? this.option,
      );

  factory OrderProduct.fromRawJson(String str) =>
      OrderProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        productId: json["product_id"],
        name: json["name"],
        model: json["model"],
        quantity: json["quantity"],
        price: json["price"],
        total: json["total"],
        taxClassId: json["tax_class_id"],
        subtract: json["subtract"],
        option: List<OrderOption>.from(
            json["option"].map((x) => OrderOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "model": model,
        "quantity": quantity,
        "price": price,
        "total": total,
        "tax_class_id": taxClassId,
        "subtract": subtract,
        "option": List<dynamic>.from(option.map((x) => x.toJson())),
      };

  factory OrderProduct.fromCartProduct(CartProduct cartProduct) {
    String price = cartProduct.product!.specialPrice != null
        ? cartProduct.product!.specialPrice.toString()
        : cartProduct.price;
    int total = int.parse(price) * cartProduct.quantity;

    List<OrderOption> options = [];

    cartProduct.selectedOptionsIds.forEach(
      (optionId, optionValue) {
        if (optionValue.runtimeType == List<dynamic>) {
          for (String value in optionValue) {
            options.add(OrderOption.fromCartOption(
                cartProduct.product!.options
                    .firstWhere((option) => option.productOptionId == optionId),
                value));
          }
        }
        if (optionValue.runtimeType == String) {
          options.add(OrderOption.fromCartOption(
              cartProduct.product!.options
                  .firstWhere((option) => option.productOptionId == optionId),
              optionValue));
        }
      },
    );

    return OrderProduct(
        productId: cartProduct.productId,
        name: cartProduct.product!.name,
        model: cartProduct.product!.model ?? '',
        quantity: cartProduct.quantity,
        price: price,
        total: total,
        taxClassId: cartProduct.product!.taxClassId,
        option: options);
  }
}

class OrderOption {
  final String productOptionId;
  final String productOptionValueId;
  final String name;
  final String value;
  final String type;

  OrderOption({
    required this.productOptionId,
    required this.productOptionValueId,
    required this.name,
    required this.value,
    required this.type,
  });

  OrderOption copyWith({
    String? productOptionId,
    String? productOptionValueId,
    String? name,
    String? value,
    String? type,
  }) =>
      OrderOption(
        productOptionId: productOptionId ?? this.productOptionId,
        productOptionValueId: productOptionValueId ?? this.productOptionValueId,
        name: name ?? this.name,
        value: value ?? this.value,
        type: type ?? this.type,
      );

  factory OrderOption.fromRawJson(String str) =>
      OrderOption.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderOption.fromJson(Map<String, dynamic> json) => OrderOption(
        productOptionId: json["product_option_id"],
        productOptionValueId: json["product_option_value_id"],
        name: json["name"],
        value: json["value"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "product_option_id": productOptionId,
        "product_option_value_id": productOptionValueId,
        "name": name,
        "value": value,
        "type": type,
      };

  factory OrderOption.fromCartOption(
      Option option, String selectedOptionValueId) {
    ProductOptionValue productOptionValue =
        option.productOptionValue.firstWhere(
      (element) => element.productOptionValueId == selectedOptionValueId,
    );

    return OrderOption(
        productOptionId: option.productOptionId,
        productOptionValueId: selectedOptionValueId,
        name: option.name,
        value:
            '${productOptionValue.name} (${productOptionValue.pricePrefix} ${productOptionValue.price.split('.').first} р)',
        type: option.type);
  }
}

class OrderTotal {
  final String code;
  final String title;
  final double value;
  final String sortOrder;

  OrderTotal({
    required this.code,
    required this.title,
    required this.value,
    required this.sortOrder,
  });

  OrderTotal copyWith({
    String? code,
    String? title,
    double? value,
    String? sortOrder,
  }) =>
      OrderTotal(
        code: code ?? this.code,
        title: title ?? this.title,
        value: value ?? this.value,
        sortOrder: sortOrder ?? this.sortOrder,
      );

  factory OrderTotal.fromRawJson(String str) =>
      OrderTotal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderTotal.fromJson(Map<String, dynamic> json) => OrderTotal(
        code: json["code"],
        title: json["title"],
        value: json["value"],
        sortOrder: json["sort_order"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "value": value,
        "sort_order": sortOrder,
      };
}
