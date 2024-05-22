import 'package:flutter/material.dart';

import 'package:gofit/components/equipments.dart';
import 'package:gofit/components/ingredients.dart';
import 'package:gofit/components/name_rating.dart';
import 'package:gofit/components/recipe_steps.dart';
import 'package:gofit/models1/equipment_model.dart';
import 'package:gofit/models1/ingredients_model.dart';
import 'package:gofit/models1/recipe_model.dart';
import 'package:gofit/models1/recipe_steps.dart';

import '../components/Backdrop.dart';

import '../models1/meal_model.dart';

class DetailScreen extends StatefulWidget {
  //static const routeName = '/detail-screen';
  final Meal meal;
  final List<Ingredient> ingredients;
  final List<Equipment> equipments;
  final List<RecipeStepsModel> recipeSteps;
  final Recipe recipe;

  DetailScreen(
      {required this.meal,
      required this.ingredients,
      required this.equipments,
      required this.recipe,
      required this.recipeSteps});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String image = 'https://spoonacular.com/recipeImages/' +
        widget.meal.id.toString() +
        '-556x370.' +
        widget.meal.imageType;
    // final recipeId =
    //     ModalRoute.of(context).settings.arguments as String; // is the id!
    return Scaffold(
      body: SingleChildScrollView(
          child:Container(
              height: size.height*1.5, 
              width: size.width * 1.5,
              child: Column(children: [
                Backdrop(
                  size: size,
                  image: image,
                  id: widget.meal.id.toString(),
                  serves: widget.meal.servings.toString(),
                  minutes: widget.meal.readyInMinutes.toString(),
                ),
                NameandRating(size: size, meal: widget.meal),
                Ingredients(ingredient: widget.ingredients),
                Equipments(
                  equipments: widget.equipments,
                ),
                Expanded(child: RecipeSteps(widget.recipeSteps)),
              ]))
     
          ),
    );
  }
}
