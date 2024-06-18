import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import '../models/personage.dart';




class Requests{

  static const String baseUrl="https://hp-api.onrender.com";
  static Future<Personage> getRandomPersonage() async {
    final url = Uri.parse('$baseUrl/api/characters');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.isEmpty) {
        throw Exception('No characters found');
      }
      Personage personage=Personage.empty();
      while(personage.name==''||personage.image=='') {
        final randomIndex = Random().nextInt(jsonResponse.length);
        personage=Personage.fromJson(jsonResponse[randomIndex]);
      }
        print(personage.toJson());
      return personage;
    } else {
      throw Exception('Failed to load characters');
    }
  }
}