import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:tomas_matres/constants/avatars.dart';

import 'dart:convert';

class Review {
  final String reviewId;
  final String productId;
  final String customerId;
  final String author;
  final String text;
  final String rating;
  final String status;
  final DateTime dateAdded;
  final String profilePhoto;
  final Color profilePhotoColor;

  Review({
    required this.reviewId,
    required this.productId,
    required this.customerId,
    required this.author,
    required this.text,
    required this.rating,
    required this.status,
    required this.dateAdded,
    required this.profilePhoto,
    required this.profilePhotoColor,
  });

  Review copyWith({
    String? reviewId,
    String? productId,
    String? customerId,
    String? author,
    String? text,
    String? rating,
    String? status,
    DateTime? dateAdded,
    String? profilePhoto,
    Color? profilePhotoColor,
  }) =>
      Review(
        reviewId: reviewId ?? this.reviewId,
        productId: productId ?? this.productId,
        customerId: customerId ?? this.customerId,
        author: author ?? this.author,
        text: text ?? this.text,
        rating: rating ?? this.rating,
        status: status ?? this.status,
        dateAdded: dateAdded ?? this.dateAdded,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        profilePhotoColor: profilePhotoColor ?? this.profilePhotoColor,
      );

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) {
    String? name = json['author'].toString().split('#').first;
    String? gender = json['author'].toString().split('#').last;

    return Review(
      reviewId: json["review_id"],
      productId: json["product_id"],
      customerId: json["customer_id"],
      author: name,
      text: json["text"] != '' ? HtmlUnescape().convert(json["text"]) : '',
      rating: json["rating"],
      status: json["status"],
      dateAdded: DateTime.parse(json["date_added"]),
      profilePhotoColor: Avatars().getRandomAvatarColor(),
      profilePhoto: gender == PersonGender.female.name
          ? Avatars().getRandomFemaleAvatar()
          : Avatars().getRandomMaleAvatar(),
    );
  }

  Map<String, dynamic> toJson() => {
        "review_id": reviewId,
        "product_id": productId,
        "customer_id": customerId,
        "author": author,
        "text": text,
        "rating": rating,
        "status": status,
        "date_added": dateAdded.toIso8601String(),
      };
}

enum PersonGender { female, male }
