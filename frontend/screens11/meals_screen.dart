import 'package:flutter/material.dart';
import 'package:gofit/models1/equipment_model.dart';
import 'package:gofit/models1/ingredients_model.dart';
import 'package:gofit/models1/meal_model.dart';
import 'package:gofit/models1/meal_plan_model.dart';
import 'package:gofit/models1/recipe_model.dart';
import 'package:gofit/models1/recipe_steps.dart';
import 'package:gofit/screens11/recipe_screen.dart';
import 'package:gofit/services11/api_service.dart';

import '../services11/api_service.dart';

class MealsScreen extends StatefulWidget {
  final MealPlan mealPlan;

  MealsScreen({required this.mealPlan});

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  _buildTotalNutrientsCard() {
    return Container(
      height: 140.0,
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Total Nutrients',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Calories: ${widget.mealPlan.calories.toString()}cal',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
               Text(
                'Fat: ${widget.mealPlan.fat.toString()} g',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               Text(
                'Protein: ${widget.mealPlan.protein.toString()} g',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Carbs: ${widget.mealPlan.carbs.toString()} g',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                Center(child: Text('Please wait for the recipes to be loaded')),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildMealCard(Meal meal, int index, BuildContext context) {
    String mealType = _mealType(index);
    return GestureDetector(
      onTap: () async {
        _showMyDialog(context);
        List<RecipeStepsModel> recipeSteps = await APIService.instance.fetchRecipeSteps(meal.id.toString());
        List<Ingredient> ingredients =
            await APIService.instance.fetchIngredients(meal.id.toString());
        List<Equipment> equipments =
            await APIService.instance.fetchEquipment(meal.id.toString());
        Recipe recipe =
            await APIService.instance.fetchRecipeSummary(meal.id.toString());
        print(recipeSteps);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeScreen(
              meal: meal,
              mealType: mealType,
              recipe: recipe,
              ingredients: ingredients,
              equipments: equipments,
              recipeSteps:recipeSteps,
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 220.0,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage('https://spoonacular.com/recipeImages/' +
                    meal.id.toString() +
                    '-556x370.' +
                    meal.imageType),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(60.0),
            padding: EdgeInsets.all(10.0),
            color: Colors.black45,
            child: Column(
              children: <Widget>[
                Text(
                  mealType,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  meal.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _mealType(int index) {
    switch (index) {
      case 0:
        return 'Breakfast';
      case 1:
        return 'Lunch';
      case 2:
        return 'Dinner';
      default:
        return 'Breakfast';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Your Meal Plan'),
      ),
      body: ListView.builder(
        itemCount: 1 + widget.mealPlan.meals.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildTotalNutrientsCard();
          }
          Meal meal = widget.mealPlan.meals[index - 1];
          print(meal.sourceUrl);
          return _buildMealCard(meal, index - 1, context);
        },
      ),
    );
  }
}
