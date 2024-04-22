import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:tomas_matres/ui/features/products_with_sale/data/special_product_model.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<ProductAttributeGroupe> attributes;
  final String image;
  final List<String> additionalImages;
  final int price;
  final int? rating;
  final int width;
  final int height;
  final int length;
  final String? manufacturerId;
  final String? manufacturer;
  final String? model;
  final int? specialPrice;
  final String taxClassId;
  final List<Option> options;
  final List<String> relatedIds;
  final List<String> categoryIds;
  final List<ProductFilter> filters;
  final DateTime dateAdded;

  const Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.attributes,
      required this.price,
      required this.image,
      required this.additionalImages,
      this.rating,
      this.width = 0,
      this.height = 0,
      this.length = 0,
      this.manufacturerId,
      this.manufacturer,
      this.model,
      this.specialPrice,
      required this.taxClassId,
      required this.options,
      required this.relatedIds,
      required this.categoryIds,
      required this.filters,
      required this.dateAdded});

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  factory Product.fromJson(Map<String, dynamic> json) {
    int price = 0;
    int? special;
    String priceAsString = json["price"].replaceAll(' ', '');
    priceAsString = priceAsString.substring(0, priceAsString.length - 1);
    price = int.parse(priceAsString);

    if (json["special"] != null && json["special"].runtimeType == String) {
      String priceAsString = json["special"].replaceAll(' ', '');
      priceAsString = priceAsString.substring(0, priceAsString.length - 1);
      special = int.parse(priceAsString);
    }

    return Product(
      id: json["product_id"],
      name: json["name"] != '' ? HtmlUnescape().convert(json["name"]) : '',
      description: json["description"],
      attributes: List<ProductAttributeGroupe>.from(
          json["attributes"].map((x) => ProductAttributeGroupe.fromJson(x))),
      image: json["thumb"],
      additionalImages: json["additional_images"] != null
          ? List<String>.from(
              jsonDecode(json["additional_images"]).map((x) => x.toString()))
          : [],
      price: price,
      specialPrice: special,
      rating: json["rating"],
      width: double.parse(json["width"] ?? 0).toInt(),
      height: double.parse(json["height"] ?? 0).toInt(),
      length: double.parse(json["length"] ?? 0).toInt(),
      manufacturerId: json["manufacturer_id"],
      manufacturer: json["manufacturer"],
      taxClassId: json['tax_class_id'],
      model: json["model"],
      options: json["options"] != null
          ? List<Option>.from(json["options"].map((x) => Option.fromJson(x)))
          : [],
      relatedIds: json["related_ids"] != null
          ? List<String>.from(
              jsonDecode(json["related_ids"]).map((x) => x.toString()))
          : [],
      categoryIds: json["category_ids"] != null
          ? List<String>.from(
              jsonDecode(json["category_ids"]).map((x) => x.toString()))
          : [],
      filters: json["filters"] != null
          ? List<ProductFilter>.from(
              json["filters"].map((x) => ProductFilter.fromJson(x)))
          : [],
      dateAdded: DateTime.parse(json["date_added"]),
    );
  }

  static Product fromSpecialProduct(SpecialProduct specialProduct) {
    return Product(
        id: specialProduct.productId,
        name: specialProduct.name.isNotEmpty
            ? HtmlUnescape().convert(specialProduct.name)
            : specialProduct.name,
        description: specialProduct.description,
        attributes: specialProduct.attributes,
        image: specialProduct.thumb,
        additionalImages: specialProduct.additionalImages,
        price: specialProduct.price,
        specialPrice: specialProduct.special,
        model: specialProduct.model,
        manufacturerId: specialProduct.manufacturerId,
        manufacturer: specialProduct.manufacturer,
        taxClassId: specialProduct.taxClassId,
        options: specialProduct.options,
        relatedIds: specialProduct.relatedIds,
        categoryIds: specialProduct.categoryIds,
        filters: specialProduct.filters,
        dateAdded: specialProduct.dateAdded);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        attributes,
        relatedIds,
        categoryIds,
        filters,
        image,
        additionalImages,
        price,
        rating,
        width,
        height,
        length,
        manufacturerId,
        manufacturer,
        model,
        specialPrice,
        dateAdded,
        taxClassId,
      ];
}

class Option {
  final String productOptionId;
  final List<ProductOptionValue> productOptionValue;
  final String optionId;
  final String name;
  final String type;
  final String value;
  final String required;

  Option({
    required this.productOptionId,
    required this.productOptionValue,
    required this.optionId,
    required this.name,
    required this.type,
    required this.value,
    required this.required,
  });

  Option copyWith({
    String? productOptionId,
    List<ProductOptionValue>? productOptionValue,
    String? optionId,
    String? name,
    String? type,
    String? value,
    String? required,
  }) =>
      Option(
        productOptionId: productOptionId ?? this.productOptionId,
        productOptionValue: productOptionValue ?? this.productOptionValue,
        optionId: optionId ?? this.optionId,
        name: name ?? this.name,
        type: type ?? this.type,
        value: value ?? this.value,
        required: required ?? this.required,
      );

  factory Option.fromRawJson(String str) => Option.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        productOptionId: json["product_option_id"],
        productOptionValue: List<ProductOptionValue>.from(
            json["product_option_value"]
                .map((x) => ProductOptionValue.fromJson(x))),
        optionId: json["option_id"],
        name: json["name"],
        type: json["type"],
        value: json["value"],
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
        "product_option_id": productOptionId,
        "product_option_value":
            List<dynamic>.from(productOptionValue.map((x) => x.toJson())),
        "option_id": optionId,
        "name": name,
        "type": type,
        "value": value,
        "required": required,
      };
}

class ProductOptionValue {
  final String productOptionValueId;
  final String optionValueId;
  final String name;
  final String image;
  final String quantity;
  final String subtract;
  final String price;
  final String pricePrefix;
  final String weight;
  final String weightPrefix;

  ProductOptionValue({
    required this.productOptionValueId,
    required this.optionValueId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.subtract,
    required this.price,
    required this.pricePrefix,
    required this.weight,
    required this.weightPrefix,
  });

  ProductOptionValue copyWith({
    String? productOptionValueId,
    String? optionValueId,
    String? name,
    String? image,
    String? quantity,
    String? subtract,
    String? price,
    String? pricePrefix,
    String? weight,
    String? weightPrefix,
  }) =>
      ProductOptionValue(
        productOptionValueId: productOptionValueId ?? this.productOptionValueId,
        optionValueId: optionValueId ?? this.optionValueId,
        name: name ?? this.name,
        image: image ?? this.image,
        quantity: quantity ?? this.quantity,
        subtract: subtract ?? this.subtract,
        price: price ?? this.price,
        pricePrefix: pricePrefix ?? this.pricePrefix,
        weight: weight ?? this.weight,
        weightPrefix: weightPrefix ?? this.weightPrefix,
      );

  factory ProductOptionValue.fromRawJson(String str) =>
      ProductOptionValue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductOptionValue.fromJson(Map<String, dynamic> json) =>
      ProductOptionValue(
        productOptionValueId: json["product_option_value_id"],
        optionValueId: json["option_value_id"],
        name: json["name"] != '' ? HtmlUnescape().convert(json["name"]) : '',
        image: json["image"],
        quantity: json["quantity"],
        subtract: json["subtract"],
        price: json["price"],
        pricePrefix: json["price_prefix"],
        weight: json["weight"],
        weightPrefix: json["weight_prefix"],
      );

  Map<String, dynamic> toJson() => {
        "product_option_value_id": productOptionValueId,
        "option_value_id": optionValueId,
        "name": name,
        "image": image,
        "quantity": quantity,
        "subtract": subtract,
        "price": price,
        "price_prefix": pricePrefix,
        "weight": weight,
        "weight_prefix": weightPrefix,
      };
}

class ProductAttributeGroupe {
  final String attributeGroupId;
  final String name;
  final List<ProductAttribute> attribute;

  ProductAttributeGroupe({
    required this.attributeGroupId,
    required this.name,
    required this.attribute,
  });

  ProductAttributeGroupe copyWith({
    String? attributeGroupId,
    String? name,
    List<ProductAttribute>? attribute,
  }) =>
      ProductAttributeGroupe(
        attributeGroupId: attributeGroupId ?? this.attributeGroupId,
        name: name ?? this.name,
        attribute: attribute ?? this.attribute,
      );

  factory ProductAttributeGroupe.fromRawJson(String str) =>
      ProductAttributeGroupe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAttributeGroupe.fromJson(Map<String, dynamic> json) =>
      ProductAttributeGroupe(
        attributeGroupId: json["attribute_group_id"],
        name: json["name"],
        attribute: List<ProductAttribute>.from(
            json["attribute"].map((x) => ProductAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attribute_group_id": attributeGroupId,
        "name": name,
        "attribute": List<dynamic>.from(attribute.map((x) => x.toJson())),
      };
}

class ProductAttribute {
  final String attributeId;
  final String name;
  final String text;

  ProductAttribute({
    required this.attributeId,
    required this.name,
    required this.text,
  });

  ProductAttribute copyWith({
    String? attributeId,
    String? name,
    String? text,
  }) =>
      ProductAttribute(
        attributeId: attributeId ?? this.attributeId,
        name: name ?? this.name,
        text: text ?? this.text,
      );

  factory ProductAttribute.fromRawJson(String str) =>
      ProductAttribute.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAttribute.fromJson(Map<String, dynamic> json) =>
      ProductAttribute(
        attributeId: json["attribute_id"],
        name: json["name"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "attribute_id": attributeId,
        "name": name,
        "text": text,
      };
}

class ProductFilter {
  final String filterId;
  final String filterName;
  final String filterGroupId;
  final String filterGroupName;

  ProductFilter({
    required this.filterId,
    required this.filterName,
    required this.filterGroupId,
    required this.filterGroupName,
  });

  ProductFilter copyWith({
    String? filterId,
    String? filterName,
    String? filterGroupId,
    String? filterGroupName,
  }) =>
      ProductFilter(
        filterId: filterId ?? this.filterId,
        filterName: filterName ?? this.filterName,
        filterGroupId: filterGroupId ?? this.filterGroupId,
        filterGroupName: filterGroupName ?? this.filterGroupName,
      );

  factory ProductFilter.fromRawJson(String str) =>
      ProductFilter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductFilter.fromJson(Map<String, dynamic> json) => ProductFilter(
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
