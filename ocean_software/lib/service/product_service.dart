import 'dart:convert';

import 'package:ocean_software/model/product.dart';

import '../json.dart';

class ProductService {
  static ProductService? instance;
  ProductService._();
  static ProductService getInstance() {
    instance ??= ProductService._();
    return instance!;
  }

  Category allCategory = Category(id: "All", name: "All", slug: "All");

  Product getProduct() {
    return productFromJson(jsonEncode(JsonValue.jsonValue));
  }

  List<Category> getCatergories() {
    Product _product = productFromJson(jsonEncode(JsonValue.jsonValue));
    List<Category> categories = [];
    categories.add(allCategory);
    _product.data!.map((e) {
      if (!categories.any((element) => element.id == e.category!.id)) {
        categories.add(e.category!);
      }
    }).toList();
    return categories;
  }
}
