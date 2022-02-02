import 'dart:async';
import 'dart:convert';
import 'package:flutter_news/models/product.dart';
import 'package:http/http.dart' as http;

class HttpResponse {
  Future<Product?> getData() async {
    var response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/everything?q=keyword&apiKey=6473daea317d47c7ba9518dd05bce01a'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      var rensponseJson = Product.fromJson(json.decode(response.body));
      return rensponseJson;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
