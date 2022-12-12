import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:pbp_e_03_flutter/shared/service/http_service.dart';


class Product {
  int id;
  var image;
  String name;
  int stock;
  int price;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.stock,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    stock: json["stock"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "image": image,
    "title": name,
    "stock": stock,
    "price": price,
  };
}

List<Product> ProductFromJson(String str) => List<Product>.from(
    json.decode(str).map((x) => Product.fromJson(x)));

String ProductToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Future<Map<String, dynamic>> fetchData(int page) async{
  const String _baseUrl = String.fromEnvironment("API_URL");
  final Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  Uri url = Uri.parse(path.join(_baseUrl, "market/product?page=" + page.toString()));

  var response = await http.get(url, headers: headers);
  Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
  return data;
}

List<Product> getProduct(dynamic data){
  List<Product> listProduct = [];
  for (var w in data) {
    if (w != null) {
      listProduct.add(Product.fromJson(w));
    }
  }
  return listProduct;
}