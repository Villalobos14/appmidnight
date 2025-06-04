import "dart:convert";

import "package:http/http.dart" as http;
import "../models/product_model.dart";

class ProductService {
  static const String _baseUrl = "fakestoreapi.com";
  static const String _productsPath = "/products";

  Future<List<Product>> fetchProducts() async {
    final Uri url = Uri.https(_baseUrl, _productsPath);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
  Future<Product> fetchProductById(int id) async {
    final Uri url = Uri.https(_baseUrl, "$_productsPath/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception("Failed to load product");
    }
  }
  
}