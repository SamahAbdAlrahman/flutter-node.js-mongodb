import 'dart:convert';
import 'dart:io';
import 'package:gofit/models1/equipment_model.dart';
import 'package:gofit/models1/ingredients_model.dart';
import 'package:gofit/models1/meal_plan_model.dart';
import 'package:gofit/models1/recipe_model.dart';
import 'package:gofit/models1/recipe_steps.dart';
import 'package:http/http.dart' as http;

class APIService {

  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'api.spoonacular.com';
  static const String API_KEY =  '07cea432c31b48a5bfab8aeb3ea806d6';
  
                                
  // Generate Meal Plan
  Future<MealPlan> generateMealPlan({required int targetCalories, required String diet}) async {
    if (diet == 'None') diet = '';
    print(targetCalories);
    print(diet);
    Map<String, String> parameters = {
      'timeFrame': 'day',
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/recipes/mealplans/generate',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      MealPlan mealPlan = MealPlan.fromMap(data);
      // print(data);
      return mealPlan;
    } catch (err) {
      throw err.toString();
    }
  }

  // Recipe Info
  // Future<Recipe> fetchRecipe(String id) async {
  //   Map<String, String> parameters = {
  //     'includeNutrition': 'false',
  //     'apiKey': API_KEY,
  //   };
  //   Uri uri = Uri.https(
  //     _baseUrl,
  //     '/recipes/$id/information',
  //     parameters,
  //   );
  //   Map<String, String> headers = {
  //     HttpHeaders.contentTypeHeader: 'application/json',
  //   };

  //   try {
  //     var response = await http.get(uri, headers: headers);
  //     Map<String, dynamic> data = json.decode(response.body);
  //     Recipe recipe = Recipe.fromMap(data);
  //     return recipe;
  //   } catch (err) {
  //     throw err.toString();
  //   }
  // }
  Future<Recipe> fetchRecipeSummary(String id) async {
    Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/recipes/$id/summary',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      Recipe recipe = Recipe(id: data['id'].toString(), title: data['title'],summary: data['summary']);
      return recipe;
    } catch (err) {
      throw err.toString();
    }
  }
  
  Future<List<Ingredient>> fetchIngredients(String id) async {
    Map<String, String> parameters = {
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/recipes/$id/ingredientWidget.json',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      var data = jsonDecode(response.body)['ingredients'] as List;
      List<Ingredient> ingredients = data.map((tagJson) => Ingredient.fromJson(tagJson)).toList();
      // print(ingredients);
      return ingredients;
    } catch (err) {
      throw err.toString();
    }
  }

 Future<List<Equipment>> fetchEquipment(String id) async {
    Map<String, String> parameters = {
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/recipes/$id/equipmentWidget.json',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      var data = jsonDecode(response.body)['equipment'] as List;
      List<Equipment> equipments = data.map((tagJson) => Equipment.fromJson(tagJson)).toList();
      // print(equipments);
      return equipments;
    } catch (err) {
      throw err.toString();
    }
  }


Future<List<RecipeStepsModel>> fetchRecipeSteps(String id) async {
    Map<String, String> parameters = {
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/recipes/$id/analyzedInstructions',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      // print(response.body);
      var data = jsonDecode(response.body)[0]['steps'] as List;
      // print(data);
     List<RecipeStepsModel> recipeSteps = data.map((tagJson) => RecipeStepsModel.fromJson(tagJson)).toList();
    //  print(recipeSteps);
      return recipeSteps;
    } catch (err) {
      throw err.toString();
    }
  }

}