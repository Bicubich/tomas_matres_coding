import 'dart:convert';

class DefaultCustomer {
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;
  final String address1;
  final String address2;
  final String company;
  final String city;
  final String postcode;
  final String countryId;
  final String zoneId;
  final String password;
  final String confirm;
  final String newsletter;

  DefaultCustomer({
    this.firstname = 'Пользователь',
    this.lastname = 'Пользователь',
    required this.email,
    this.telephone = '+79999999999',
    this.address1 = 'address',
    this.address2 = 'address',
    this.company = '',
    this.city = 'city',
    this.postcode = '11111',
    this.countryId = '176',
    this.zoneId = '2726',
    this.password = '52095209',
    this.confirm = '52095209',
    this.newsletter = '0',
  });

  DefaultCustomer copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? telephone,
    String? address1,
    String? address2,
    String? company,
    String? city,
    String? postcode,
    String? countryId,
    String? zoneId,
    String? password,
    String? confirm,
    String? newsletter,
  }) =>
      DefaultCustomer(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        telephone: telephone ?? this.telephone,
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        company: company ?? this.company,
        city: city ?? this.city,
        postcode: postcode ?? this.postcode,
        countryId: countryId ?? this.countryId,
        zoneId: zoneId ?? this.zoneId,
        password: password ?? this.password,
        confirm: confirm ?? this.confirm,
        newsletter: newsletter ?? this.newsletter,
      );

  factory DefaultCustomer.fromRawJson(String str) =>
      DefaultCustomer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DefaultCustomer.fromJson(Map<String, dynamic> json) =>
      DefaultCustomer(
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        telephone: json["telephone"],
        address1: json["address_1"],
        address2: json["address_2"],
        company: json["company"],
        city: json["city"],
        postcode: json["postcode"],
        countryId: json["country_id"],
        zoneId: json["zone_id"],
        password: json["password"],
        confirm: json["confirm"],
        newsletter: json["newsletter"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "telephone": telephone,
        "address_1": address1,
        "address_2": address2,
        "company": company,
        "city": city,
        "postcode": postcode,
        "country_id": countryId,
        "zone_id": zoneId,
        "password": password,
        "confirm": confirm,
        "newsletter": newsletter,
      };
}
