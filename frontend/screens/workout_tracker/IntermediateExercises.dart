import 'dart:convert';

import 'package:gofit/common/colo_extension.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:io';


import '../../configs.dart';

class IntermediateExercises extends StatefulWidget {
  const IntermediateExercises({super.key});

  // final Map dObj;
  // const WorkoutDetailView({super.key, required this.dObj});

  @override
  State<IntermediateExercises> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<IntermediateExercises> {
  TextEditingController exerciseName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController videoPath = TextEditingController();
  final bool _isNotValidate = false;
  Future<List<ExerciseItem>> fetchExercises() async {
    final apiUrl = Uri.parse(intermediateexercises); // Replace with your API endpoint
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((exercise) {
        return ExerciseItem(
          exerciseName: exercise['exerciseName'],
          description: exercise['description'],
          videoPath: exercise['videoPath'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }
  // final List<ExerciseItem> exerciseItems = [];
  List<ExerciseItem> exerciseItems = [];
  @override
  void initState() {
    super.initState();
    // Call fetchExercises when the page is opened
    fetchExercises().then((exercises) {
      setState(() {
        exerciseItems = exercises;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      decoration:
      BoxDecoration(gradient: LinearGradient(colors: TColor.primaryG)),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leadingWidth: 0,
              leading: Container(),
              expandedHeight: media.width * 0.5,
              flexibleSpace: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Free Strengths Training",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Achieve your fitness goals with this workout.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Free Strengths Training",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),

                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Exercises",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),

                        ],
                      ),
                      // add here a img with title and sub title
                      _buildHeaderImage(),
                      _buildHeaderImage2(),
                      _buildHeaderImage3(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: exerciseItems.length,
                        itemBuilder: (context, index) {
                          return ExerciseListItem(
                              exerciseName: exerciseItems[index].exerciseName,
                              description: exerciseItems[index].description,
                              videoPath:exerciseItems[index].videoPath
                          );
                        },
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ExerciseItem {
  final String exerciseName;
  final String description;
  final String videoPath;

  ExerciseItem({
    required this.exerciseName,
    required this.description,
    required this.videoPath,
  });
}

// Create a widget to display each exercise item
class ExerciseListItem extends StatelessWidget {
  final String exerciseName;
  final String description;
  final String videoPath;

  const ExerciseListItem({super.key, 
    required this.exerciseName,
    required this.description,
    required this.videoPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.file(
          File(videoPath), // Load the image from the file path
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
Widget _buildHeaderImage() {
  return Column(
    children: [
      const SizedBox(height: 30),
      Text(
        "Plank Exercise",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      Image.asset(
        // "assets/img/ggg1.png", // استبدل بمسار الصورة الفعلي
        "assets/img/pp_6.png", // استبدل بمسار الصورة الفعلي
        width: 360,
        height:180,
        fit: BoxFit.cover,
      ),

      const SizedBox(height: 19),
      Text(
        'Perform the plank exercise by starting facedown, supporting your weight on forearms and toes, maintaining a straight line from head to heels, and holding for as long as possible. Begin with shorter durations and gradually increase over time, focusing on proper form and breathing.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
      ),
    ],
  );
}

Widget _buildHeaderImage2() {
  return Column(
    children: [
      const SizedBox(height: 50),
      Text(
        "Leg Stretching Exercise",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      Image.asset(
        "assets/img/ggg.png", // استبدل بمسار الصورة الفعلي
        width: 360,
        height:180,
        fit: BoxFit.cover,
      ),


      const SizedBox(height: 19),
      Text(
        'Remember to perform the stretch gradually and avoid bouncing. Incorporate leg stretches into your regular routine to improve flexibility and reduce muscle tension',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
      ),
    ],
  );
}
Widget _buildHeaderImage3() {
  return Column(
    children: [
      const SizedBox(height: 50),

      Text(
        "Yoga Exercise",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      Image.asset(
        "assets/img/ggg1.png", // استبدل بمسار الصورة الفعلي
        width: 360,
        height:180,
        fit: BoxFit.cover,
      ),

      // Remember to perform the stretch gradually and avoid bouncing. Incorporate leg stretches into your regular routine to improve flexibility and reduce muscle tension
      const SizedBox(height: 19),
      Text(
        'Remember to perform the stretch gradually and avoid bouncing. Incorporate leg stretches into your regular routine to improve flexibility and reduce muscle tension',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
      ),
    ],
  );
}