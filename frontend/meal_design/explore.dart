import 'dart:convert';
import 'recipe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'data.dart';
import 'detail.dart';
import 'package:gofit/meal_design/shared.dart';
import 'package:http/http.dart' as http;
class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  List<bool> optionSelected = [true, false, false];
  List<Recipe> meals = []; // List to store fetched meal
  RecipeService recipeService = RecipeService();

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }
  Future<void> fetchMeals() async {
    try {
      final fetchedMeals = await recipeService.getMeals();
      setState(() {
        meals = fetchedMeals;
      });
    } catch (error) {
      print('Error fetching meals: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  buildTextTitleVariation1('Healthy Meals'),

                  buildTextSubTitleVariation1('Healthy and nutritious food recipes'),

                  SizedBox(
                    height: 32,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      option('BreakFast', 'assets/icons/salad.png', 0),
                      SizedBox(
                        width: 4,
                      ),
                      option('Launch', 'assets/icons/rice.png', 1),
                      SizedBox(
                        width: 4,
                      ),
                      option('Dinner', 'assets/icons/fruit.png', 2),

                    ],
                  ),

                ],
              ),
            ),

            SizedBox(
              height: 24,
            ),

            Container(
              height: 350,
              child:ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildRecipesByOption(optionSelected.indexOf(true)),
              ),

            ),

            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [

                  buildTextTitleVariation2('Snacks', false),

                  SizedBox(
                    width: 8,
                  ),

                  buildTextTitleVariation2('Food', true),

                ],
              ),
            ),

            Container(
              height: 190,
              child: PageView(
                physics: BouncingScrollPhysics(),
                children: buildPopulars(),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget option(String text, String image, int index){
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < optionSelected.length; i++) {
            optionSelected[i] = i == index;
          }        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: optionSelected[index] ? Colors.deepOrange : Colors.white, // Change color here
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [

            SizedBox(
              height: 32,
              width: 32,
              child: Image.asset(
                image,
                color: optionSelected[index] ? Colors.white : Colors.black,
              ),
            ),

            SizedBox(
              width: 8,
            ),

            Text(
              text,
              style: TextStyle(
                color: optionSelected[index] ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }


  List<Widget> buildRecipesByOption(int optionIndex) {
    List<Widget> list = [];
    List<Recipe> recipes=[];

    // Filter recipes based on the selected option
    if (optionIndex == 0) {
      recipes = getBreakfastRecipes();
    } else if (optionIndex == 1) {
      recipes = getlaunchRecipes();
    } else if (optionIndex == 2) {
      recipes = getDinnerRecipes();
    }

    // Build widgets for the filtered recipes
    for (var i = 0; i < recipes.length; i++) {
      list.add(buildRecipe(recipes[i], i));
    }
    return list;
  }

  Widget buildRecipe(Recipe recipe, int index){
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(recipe: recipe)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0, bottom: 16, top: 8),
        padding: EdgeInsets.all(16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Expanded(
              child: Hero(
                tag: recipe.image,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(recipe.image),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 8,
            ),

            buildRecipeTitle(recipe.title),

            buildTextSubTitleVariation2(recipe.description),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                buildCalories(recipe.calories.toString() + " Kcal"),



              ],
            ),

          ],
        ),
      ),
    );
  }

  List<Widget> buildPopulars(){
    List<Widget> list = [];

    for (var i = 0; i < snacks().length; i++) {
      list.add(buildPopular(snacks()[i]));
    }
    return list;
  }

  Widget buildPopular(Recipe recipe){
    return  GestureDetector(
        onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Detail(recipe: recipe)),
      );
    },
      child:Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Row(
        children: [

          Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(recipe.image),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  buildRecipeTitle(recipe.title),

                  buildRecipeSubTitle(recipe.description),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      buildCalories(recipe.calories.toString() + " Kcal"),



                    ],
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    ),
    );
  }

}