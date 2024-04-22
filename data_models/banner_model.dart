import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';

class TomasBanner {
  final String bannerId;
  final String name;
  final String title;
  final String description;
  final bool showTimer;
  final String link;
  final String chip;
  final String additionalText;
  final bool isDarkText;
  final String image;

  TomasBanner({
    required this.bannerId,
    required this.name,
    required this.title,
    required this.description,
    required this.showTimer,
    required this.link,
    required this.chip,
    required this.additionalText,
    required this.isDarkText,
    required this.image,
  });

  TomasBanner copyWith({
    String? bannerId,
    String? name,
    String? title,
    String? description,
    bool? showTimer,
    String? link,
    String? chip,
    String? additionalText,
    bool? isDarkText,
    String? image,
  }) =>
      TomasBanner(
        bannerId: bannerId ?? this.bannerId,
        name: name ?? this.name,
        title: title ?? this.title,
        description: description ?? this.description,
        showTimer: showTimer ?? this.showTimer,
        link: link ?? this.link,
        chip: chip ?? this.chip,
        additionalText: additionalText ?? this.additionalText,
        isDarkText: isDarkText ?? this.isDarkText,
        image: image ?? this.image,
      );

  factory TomasBanner.fromRawJson(String str) =>
      TomasBanner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TomasBanner.fromJson(Map<String, dynamic> json) => TomasBanner(
        bannerId: json["banner_id"],
        name: json["name"],
        title: json["title"],
        description: json["description"],
        showTimer: json["show_timer"] == "1" ? true : false,
        link: json["link"] != '' ? HtmlUnescape().convert(json["link"]) : '',
        chip: json["chip"],
        additionalText: json["additional_text"],
        isDarkText: json["is_dark_additional_text"] == "1" ? true : false,
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "banner_id": bannerId,
        "name": name,
        "title": title,
        "description": description,
        "show_timer": showTimer,
        "link": link,
        "chip": chip,
        "additional_text": additionalText,
        "is_dark_additional_text": isDarkText,
        "image": image,
      };
}
