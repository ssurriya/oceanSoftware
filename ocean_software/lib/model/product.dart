// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.data,
    this.status,
    this.message,
  });

  List<Datum>? data;
  int? status;
  String? message;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.price,
    this.category,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.image,
  });

  String? id;
  String? title;
  int? price;
  Category? category;
  String? description;
  CreatedBy? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? slug;
  String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        title: json["title"],
        price: json["price"],
        category: Category.fromJson(json["category"]),
        description: json["description"] == null ? null : json["description"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        slug: json["slug"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "price": price,
        "category": category!.toJson(),
        "description": description == null ? null : description,
        "createdBy": createdBy!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "slug": slug,
        "image": image == null ? null : image,
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
  });

  String? id;
  String? name;
  String? slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
      };
}

class CreatedBy {
  CreatedBy({
    this.role,
    this.id,
    this.name,
  });

  Role? role;
  String? id;
  String? name;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        role: roleValues.map![json["role"]],
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "role": roleValues.reverse[role],
        "_id": id,
        "name": name,
      };
}

enum Role { ROLE_CUSTOMER, ROLE_SUPER_ADMIN }

final roleValues = EnumValues({
  "ROLE_CUSTOMER": Role.ROLE_CUSTOMER,
  "ROLE_SUPER_ADMIN": Role.ROLE_SUPER_ADMIN
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
