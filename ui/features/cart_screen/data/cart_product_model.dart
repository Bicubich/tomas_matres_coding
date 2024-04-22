import 'dart:convert';

import 'package:tomas_matres/ui/components/products_grid_view/data/product_model.dart';

class CartProduct {
  final String cartId;
  final String apiId;
  final String customerId;
  final String sessionId;
  final String productId;
  final String subscriptionPlanId;
  final Map<String, dynamic> selectedOptionsIds;
  final int quantity;
  final String override;
  final String price;
  final DateTime dateAdded;
  final Product? product;

  CartProduct({
    required this.cartId,
    required this.apiId,
    required this.customerId,
    required this.sessionId,
    required this.productId,
    required this.subscriptionPlanId,
    required this.selectedOptionsIds,
    required this.quantity,
    required this.override,
    required this.price,
    required this.dateAdded,
    this.product,
  });

  CartProduct copyWith(
          {String? cartId,
          String? apiId,
          String? customerId,
          String? sessionId,
          String? productId,
          String? subscriptionPlanId,
          Map<String, dynamic>? optionsAsIds,
          int? quantity,
          String? override,
          String? price,
          DateTime? dateAdded,
          Product? product}) =>
      CartProduct(
        cartId: cartId ?? this.cartId,
        apiId: apiId ?? this.apiId,
        customerId: customerId ?? this.customerId,
        sessionId: sessionId ?? this.sessionId,
        productId: productId ?? this.productId,
        subscriptionPlanId: subscriptionPlanId ?? this.subscriptionPlanId,
        selectedOptionsIds: optionsAsIds ?? selectedOptionsIds,
        quantity: quantity ?? this.quantity,
        override: override ?? this.override,
        price: price ?? this.price,
        dateAdded: dateAdded ?? this.dateAdded,
        product: product ?? this.product,
      );

  factory CartProduct.fromRawJson(String str) =>
      CartProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> selectedOptionsIds = {};
    if (jsonDecode(json['option']).runtimeType != List<dynamic>) {
      selectedOptionsIds = jsonDecode(json['option']);
    }

    return CartProduct(
      cartId: json["cart_id"],
      apiId: json["api_id"],
      customerId: json["customer_id"],
      sessionId: json["session_id"],
      productId: json["product_id"],
      subscriptionPlanId: json["subscription_plan_id"],
      selectedOptionsIds: selectedOptionsIds,
      quantity: int.parse(json["quantity"]),
      override: json["override"] ?? '0',
      price: json["price"] ?? '0',
      dateAdded: DateTime.parse(json["date_added"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "api_id": apiId,
        "customer_id": customerId,
        "session_id": sessionId,
        "product_id": productId,
        "subscription_plan_id": subscriptionPlanId,
        "quantity": quantity,
        "override": override,
        "price": price,
        "date_added": dateAdded.toIso8601String(),
      };
}
