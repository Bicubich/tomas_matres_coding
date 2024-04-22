import 'dart:convert';

class Customer {
    final String customerId;
    final String customerGroupId;
    final String storeId;
    final String languageId;
    final String firstname;
    final String lastname;
    final String email;
    final String telephone;
    final String newsletter;
    final String customField;
    final String ip;
    final String status;
    final String safe;
    final String token;
    final String code;
    final DateTime dateAdded;

    Customer({
        required this.customerId,
        required this.customerGroupId,
        required this.storeId,
        required this.languageId,
        required this.firstname,
        required this.lastname,
        required this.email,
        required this.telephone,
        required this.newsletter,
        required this.customField,
        required this.ip,
        required this.status,
        required this.safe,
        required this.token,
        required this.code,
        required this.dateAdded,
    });

    Customer copyWith({
        String? customerId,
        String? customerGroupId,
        String? storeId,
        String? languageId,
        String? firstname,
        String? lastname,
        String? email,
        String? telephone,
        String? newsletter,
        String? customField,
        String? ip,
        String? status,
        String? safe,
        String? token,
        String? code,
        DateTime? dateAdded,
    }) => 
        Customer(
            customerId: customerId ?? this.customerId,
            customerGroupId: customerGroupId ?? this.customerGroupId,
            storeId: storeId ?? this.storeId,
            languageId: languageId ?? this.languageId,
            firstname: firstname ?? this.firstname,
            lastname: lastname ?? this.lastname,
            email: email ?? this.email,
            telephone: telephone ?? this.telephone,
            newsletter: newsletter ?? this.newsletter,
            customField: customField ?? this.customField,
            ip: ip ?? this.ip,
            status: status ?? this.status,
            safe: safe ?? this.safe,
            token: token ?? this.token,
            code: code ?? this.code,
            dateAdded: dateAdded ?? this.dateAdded,
        );

    factory Customer.fromRawJson(String str) => Customer.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json["customer_id"],
        customerGroupId: json["customer_group_id"],
        storeId: json["store_id"],
        languageId: json["language_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        telephone: json["telephone"],
        newsletter: json["newsletter"],
        customField: json["custom_field"],
        ip: json["ip"],
        status: json["status"],
        safe: json["safe"],
        token: json["token"],
        code: json["code"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_group_id": customerGroupId,
        "store_id": storeId,
        "language_id": languageId,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "telephone": telephone,
        "newsletter": newsletter,
        "custom_field": customField,
        "ip": ip,
        "status": status,
        "safe": safe,
        "token": token,
        "code": code,
        "date_added": dateAdded.toIso8601String(),
    };
}
