import 'dart:convert';

import 'Image.dart';

class Ad {
  int id;
  String title;
  String description;
  bool isExchangePossible;
  bool isDeliveryPossible;
  double price;
  DateTime dateCreated;
  String type;
  String condition;
  List<Imagee> images;
  String category;
  String city;
  List<dynamic> comments;
  int advertisedByUser;
  bool isLiked = false;

  Ad({
    required this.id,
    required this.title,
    required this.description,
    required this.isExchangePossible,
    required this.isDeliveryPossible,
    required this.price,
    required this.dateCreated,
    required this.type,
    required this.condition,
    required this.images,
    required this.category,
    required this.city,
    required this.comments,
    required this.advertisedByUser,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    isExchangePossible: json["isExchangePossible"],
    isDeliveryPossible: json["isDeliveryPossible"],
    price: json["price"],
    dateCreated: DateTime.parse(json["dateCreated"]),
    type: json["type"],
    condition: json["condition"],
    images: List<Imagee>.from(json["images"].map((x) => Imagee.fromJson(x))),
    category: json["category"],
    city: json["city"],
    comments: List<dynamic>.from(json["comments"].map((x) => x)),
    advertisedByUser: json["advertisedByUser"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "isExchangePossible": isExchangePossible,
    "isDeliveryPossible": isDeliveryPossible,
    "price": price,
    "dateCreated": dateCreated.toIso8601String(),
    "type": type,
    "condition": condition,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "category": category,
    "city": city,
    "comments": List<dynamic>.from(comments.map((x) => x)),
    "advertisedByUser": advertisedByUser,
  };
  List<Ad> AdFromJson(String str) => List<Ad>.from(json.decode(str).map((x) => Ad.fromJson(x)));

}