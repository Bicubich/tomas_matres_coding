import 'dart:convert';

class Zone {
  final String zoneId;
  final String? countryId;
  final String name;
  final String code;
  final String? status;
  final String? isoCode2;
  final String? isoCode3;
  final String? addressFormatId;
  final String? postcodeRequired;
  final String? country;

  Zone({
    required this.zoneId,
    required this.countryId,
    required this.name,
    required this.code,
    required this.status,
    required this.isoCode2,
    required this.isoCode3,
    required this.addressFormatId,
    required this.postcodeRequired,
    required this.country,
  });

  Zone copyWith({
    String? zoneId,
    String? countryId,
    String? name,
    String? code,
    String? status,
    String? isoCode2,
    String? isoCode3,
    String? addressFormatId,
    String? postcodeRequired,
    String? country,
  }) =>
      Zone(
        zoneId: zoneId ?? this.zoneId,
        countryId: countryId ?? this.countryId,
        name: name ?? this.name,
        code: code ?? this.code,
        status: status ?? this.status,
        isoCode2: isoCode2 ?? this.isoCode2,
        isoCode3: isoCode3 ?? this.isoCode3,
        addressFormatId: addressFormatId ?? this.addressFormatId,
        postcodeRequired: postcodeRequired ?? this.postcodeRequired,
        country: country ?? this.country,
      );

  factory Zone.fromRawJson(String str) => Zone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        zoneId: json["zone_id"],
        countryId: json["country_id"],
        name: json["name"],
        code: json["code"],
        status: json["status"],
        isoCode2: json["iso_code_2"],
        isoCode3: json["iso_code_3"],
        addressFormatId: json["address_format_id"],
        postcodeRequired: json["postcode_required"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "zone_id": zoneId,
        "country_id": countryId,
        "name": name,
        "code": code,
        "status": status,
        "iso_code_2": isoCode2,
        "iso_code_3": isoCode3,
        "address_format_id": addressFormatId,
        "postcode_required": postcodeRequired,
        "country": country,
      };
}
