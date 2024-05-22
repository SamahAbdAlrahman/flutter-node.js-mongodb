import 'package:flutter/material.dart';
import 'package:gofit/models1/equipment_model.dart';
import 'package:gofit/models1/ingredients_model.dart';
import 'package:gofit/models1/recipe_model.dart';
import 'package:gofit/models1/recipe_steps.dart';
import 'package:gofit/screens11/detail_screen.dart';

import '../models1/meal_model.dart';

class RecipeScreen extends StatefulWidget {
  final String mealType;
  final Recipe recipe;
  final List<Ingredient> ingredients;
  final List<Equipment> equipments;
  final Meal meal;
  final List<RecipeStepsModel> recipeSteps;


  RecipeScreen({required this.meal, required this.mealType, required this.recipe, required this.ingredients , required this.equipments, required this.recipeSteps});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
 
  
  @override
  Widget build(BuildContext context) {
     print(widget.ingredients);
    return Scaffold(
        body:DetailScreen(meal:widget.meal,ingredients:widget.ingredients , equipments:widget.equipments, recipe:widget.recipe, recipeSteps:widget.recipeSteps), 
        );
  }
}
