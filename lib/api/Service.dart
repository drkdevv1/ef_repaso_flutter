import 'package:ef_repaso_flutter/api/Breed.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  static Future<List<Breed>> getAllBreeds() async {
    final response =
        await http.get(Uri.parse("https://api.thecatapi.com/v1/breeds"));
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((breed) => Breed.fromJson(breed)).toList();
    } else {
      throw Exception('Error de consumo de API');
    }
  }

  static Future<String> getRandomCatImageUrl() async {
    final response =
        await http.get(Uri.parse("https://api.thecatapi.com/v1/images/search"));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.isNotEmpty) {
        return jsonResponse[0]['url'];
      } else {
        throw Exception('No image found');
      }
    } else {
      throw Exception('Error de consumo de API');
    }
  }
}
