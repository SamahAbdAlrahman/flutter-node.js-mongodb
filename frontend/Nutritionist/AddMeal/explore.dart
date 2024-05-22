import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gofit/Nutritionist/AddMeal/constants.dart';
import 'package:gofit/Nutritionist/AddMeal/data.dart';
import 'package:gofit/Nutritionist/AddMeal/detail.dart';
import 'package:gofit/Nutritionist/AddMeal/explore.dart';
import 'package:gofit/Nutritionist/AddMeal/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../configs.dart';
class addExplore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<addExplore> {
  List<bool> optionSelected = [true, false, false];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController carbohydratesController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController recipePreparationController =
  TextEditingController();
  final TextEditingController imageController = TextEditingController();
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
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
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildRecipesByOption(optionSelected.indexOf(true)),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: Row(
            //     children: [
            //       buildTextTitleVariation2('Snacks', false),
            //       SizedBox(
            //         width: 8,
            //       ),
            //       buildTextTitleVariation2('Food', true),
            //     ],
            //   ),
            // ),
            // Container(
            //   height: 190,
            //   child: PageView(
            //     physics: BouncingScrollPhysics(),
            //     children: buildPopulars(),
            //   ),
            // ),
            ElevatedButton(
              onPressed: () {
                _showAddMealDialog();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange, // تعيين اللون البرتقالي هنا
              ),
              child: Text('Add Meal'),
            ),

          ],
        ),
      ),
    );
  }

  Widget option(String text, String image, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < optionSelected.length; i++) {
            optionSelected[i] = i == index;
          }
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: optionSelected[index] ? Colors.deepOrange : Colors.white, // Change color here
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 30, offset: Offset(0, 10))],
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
    List<Recipe> recipes = [];

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

  Widget buildRecipe(Recipe recipe, int index) {
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
          boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 30, offset: Offset(0, 10))],
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

  List<Widget> buildPopulars() {
    List<Widget> list = [];
    for (var i = 0; i < snacks().length; i++) {
      list.add(buildPopular(snacks()[i]));
    }
    return list;
  }

  Widget buildPopular(Recipe recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(recipe: recipe)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 30, offset: Offset(0, 10))],
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

  void _showAddMealDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Meal"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: caloriesController,
                  decoration: InputDecoration(labelText: 'Calories'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: proteinController,
                  decoration: InputDecoration(labelText: 'Protein'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: carbohydratesController,
                  decoration: InputDecoration(labelText: 'Carbohydrates'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: ingredientsController,
                  decoration: InputDecoration(labelText: 'Ingredients'),
                ),
                TextFormField(
                  controller: recipePreparationController,
                  decoration: InputDecoration(labelText: 'Recipe Preparation'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _getImage();
                  },
                  child: Text("Choose Image"),
                ),
                _image == null
                    ? SizedBox.shrink()
                    : Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(_image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Add"),
              onPressed: () {
                addMeal();
                _showSuccessSnackBar(nameController.text, imageController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageController.text = _image!.path;
      }
    });
  }
  void _showSuccessSnackBar(String mealName, String imagePath) {
    final snackBar = SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Meal added successfully!'),
          SizedBox(height: 8),
          Text(mealName),
          SizedBox(height: 8),
          Image.file(
            File(imagePath),
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ],
      ),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> addMeal() async {
    try {
      final String apiUrl = '$iport/meal/addMeal';

      final Map<String, dynamic> requestData = {
        "name": nameController.text,
        "type": optionSelected.indexOf(true) == 0
            ? "Breakfast"
            : optionSelected.indexOf(true) == 1
            ? "Lunch"
            : "Dinner",
        "calories": int.tryParse(caloriesController.text) ?? 0,
        "protein": int.tryParse(proteinController.text) ?? 0,
        "carbohydrates": int.tryParse(carbohydratesController.text) ?? 0,
        "ingredients": ingredientsController.text.split(","),
        "recipe_preparation": recipePreparationController.text,
        "image": imageController.text,
      };

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print("Meal added successfully");
        _showSuccessSnackBar(nameController.text, imageController.text);
      } else {
        print("Failed to add meal. Error: ${response.statusCode}");
        throw Exception('Failed to add meal');
      }
    } catch (error) {
      print("Error adding meal: $error");
      // يمكنك إضافة معالجة للأخطاء هنا
    }
  }
}
