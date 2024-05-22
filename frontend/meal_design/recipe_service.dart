// recipe_service.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'data.dart';
import 'detail.dart';
import 'package:gofit/meal_design/shared.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecipeService {
  static const String baseUrl = 'http://192.168.0.107:5000'; // Replace with your backend URL

  Future<List<Recipe>> getMeals() async {
    final response = await http.get(Uri.parse('$baseUrl/getmeals'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Recipe(
        item['name'],
        item['description'],
        item['image'],
        item['calories'],
        item['carbohydrates'],
        item['protein'],
      )).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
