import 'dart:convert';

class ProductFromWishlist {
  final String customerId;
  final String productId;
  final DateTime dateAdded;

  ProductFromWishlist({
    required this.customerId,
    required this.productId,
    required this.dateAdded,
  });

  ProductFromWishlist copyWith({
    String? customerId,
    String? productId,
    DateTime? dateAdded,
  }) =>
      ProductFromWishlist(
        customerId: customerId ?? this.customerId,
        productId: productId ?? this.productId,
        dateAdded: dateAdded ?? this.dateAdded,
      );

  factory ProductFromWishlist.fromRawJson(String str) =>
      ProductFromWishlist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductFromWishlist.fromJson(Map<String, dynamic> json) =>
      ProductFromWishlist(
        customerId: json["customer_id"],
        productId: json["product_id"],
        dateAdded: DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "product_id": productId,
        "date_added": dateAdded.toIso8601String(),
      };
}
