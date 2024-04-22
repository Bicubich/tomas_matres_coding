import 'dart:convert';

import 'package:html_unescape/html_unescape.dart';
import 'package:tomas_matres/api/constants.dart';

class Category {
  final String categoryId;
  final String? languageId;
  final String name;
  final String metaTitle;
  final List<Category> children;
  final List<CategoryFilter> filters;
  final String storeId;
  final String parentId;
  final String top;
  final String sortOrder;
  final String status;
  final DateTime dateAdded;
  final DateTime dateModified;
  final String href;
  final String? description;
  final String? metaDescription;
  final String? metaKeyword;
  final String? image;
  final String? icon;

  Category({
    required this.categoryId,
    required this.languageId,
    required this.name,
    required this.metaTitle,
    required this.children,
    required this.filters,
    required this.storeId,
    required this.parentId,
    required this.top,
    required this.sortOrder,
    required this.status,
    required this.dateAdded,
    required this.dateModified,
    required this.href,
    this.description,
    this.metaDescription,
    this.metaKeyword,
    this.image,
    this.icon,
  });

  Category copyWith({
    String? categoryId,
    String? languageId,
    String? name,
    String? metaTitle,
    List<Category>? children,
    List<CategoryFilter>? filters,
    String? storeId,
    String? parentId,
    String? top,
    String? sortOrder,
    String? status,
    DateTime? dateAdded,
    DateTime? dateModified,
    String? href,
    String? description,
    String? metaDescription,
    String? metaKeyword,
    String? image,
    String? icon,
  }) =>
      Category(
        categoryId: categoryId ?? this.categoryId,
        languageId: languageId ?? this.languageId,
        name: name ?? this.name,
        metaTitle: metaTitle ?? this.metaTitle,
        children: children ?? this.children,
        filters: filters ?? this.filters,
        storeId: storeId ?? this.storeId,
        parentId: parentId ?? this.parentId,
        top: top ?? this.top,
        sortOrder: sortOrder ?? this.sortOrder,
        status: status ?? this.status,
        dateAdded: dateAdded ?? this.dateAdded,
        dateModified: dateModified ?? this.dateModified,
        href: href ?? this.href,
        description: description ?? this.description,
        metaDescription: metaDescription ?? this.metaDescription,
        metaKeyword: metaKeyword ?? this.metaKeyword,
        image: image ?? this.image,
        icon: icon ?? this.icon,
      );

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json["category_id"],
      languageId: json["language_id"],
      name: json["name"] != '' ? HtmlUnescape().convert(json["name"]) : '',
      metaTitle: json["meta_title"],
      children: json["children"] != null
          ? List<Category>.from(
              json["children"].map((x) => Category.fromJson(x)))
          : [],
      filters: json["filters"] != null
          ? List<CategoryFilter>.from(
              json["filters"].map((x) => CategoryFilter.fromJson(x)))
          : [],
      storeId: json["store_id"],
      parentId: json["parent_id"],
      top: json["top"] ?? '0',
      sortOrder: json["sort_order"],
      status: json["status"],
      dateAdded: DateTime.parse(json["date_added"]),
      dateModified: DateTime.parse(json["date_modified"]),
      href: json["href"],
      description: json["description"] != ''
          ? HtmlUnescape().convert(json["description"])
          : '',
      metaDescription: json["meta_description"],
      metaKeyword: json["meta_keyword"],
      image: json["image"] != null && json["image"] != ''
          ? ApiConstants.imageUrl + json["image"]
          : '',
      icon: json["icon"] != null && json["icon"] != ''
          ? ApiConstants.imageUrl + json["icon"]
          : '',
    );
  }

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "language_id": languageId,
        "name": name,
        "meta_title": metaTitle,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "store_id": storeId,
        "parent_id": parentId,
        "top": top,
        "sort_order": sortOrder,
        "status": status,
        "date_added": dateAdded.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "href": href,
        "description": description,
        "meta_description": metaDescription,
        "meta_keyword": metaKeyword,
        "image": image,
        "icon": icon,
      };
}

class CategoryFilter {
  final String filterId;
  final String filterName;
  final String filterGroupId;
  final String filterGroupName;

  CategoryFilter({
    required this.filterId,
    required this.filterName,
    required this.filterGroupId,
    required this.filterGroupName,
  });

  CategoryFilter copyWith({
    String? filterId,
    String? filterName,
    String? filterGroupId,
    String? filterGroupName,
  }) =>
      CategoryFilter(
        filterId: filterId ?? this.filterId,
        filterName: filterName ?? this.filterName,
        filterGroupId: filterGroupId ?? this.filterGroupId,
        filterGroupName: filterGroupName ?? this.filterGroupName,
      );

  factory CategoryFilter.fromRawJson(String str) =>
      CategoryFilter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryFilter.fromJson(Map<String, dynamic> json) => CategoryFilter(
        filterId: json["filter_id"],
        filterName: json["filter_name"],
        filterGroupId: json["filter_group_id"],
        filterGroupName: json["filter_group_name"],
      );

  Map<String, dynamic> toJson() => {
        "filter_id": filterId,
        "filter_name": filterName,
        "filter_group_id": filterGroupId,
        "filter_group_name": filterGroupName,
      };
}
