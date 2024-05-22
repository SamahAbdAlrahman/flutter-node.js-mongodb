import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../../configs.dart';


class SportsLessonsPage extends StatefulWidget {
  const SportsLessonsPage({super.key});

  @override
  _SportsLessonsPageState createState() => _SportsLessonsPageState();
}

class _SportsLessonsPageState extends State<SportsLessonsPage> {
  List<ClassData> classes = [];

  final List<String> lessonImages = [
    'assets/img/5.png',
    'assets/img/yogaaa.png',
    'assets/sports_icon3.jpg',
  ];
  int maxSubscribers = 20;
  int subscribersCount = 15;
  ValueNotifier<int> currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    // Fetch class data when the screen loads
    fetchClasses();
  }
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  Future<void> fetchClasses() async {
    final response = await http.get(Uri.parse(getClasses));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      classes = data.map((json) => ClassData.fromJson(json)).toList();

      setState(() {});
    } else {
      // Handle the error if the request fails
      print('Failed to fetch classes');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/GOFit.jfif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30.0),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_outlined),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 180.0),
            Expanded(
              child: PageView.builder(
                itemCount: classes.length,
                onPageChanged: (int page) {
                  currentPage.value = page;
                },
                itemBuilder: (context, index) {
                  return ValueListenableBuilder<int>(
                    valueListenable: currentPage,
                    builder: (context, page, child) {
                      final isCurrentPage = index == page;
                      final elevation = isCurrentPage ? 8.0 : 0.0;

                      return buildLessonCard(classes[index]);

                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLessonCard(
  ClassData classData,
      {double elevation = 0.0}
      ) {
    Color borderColor = Colors.grey; // لون الحدود
    double borderWidth = 2.0; // سمك الحدود
    bool isBookingConfirmed = false; // تمثل حالة تأكيد الحجز


    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(15),
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child:
                Image.file(
                  File(classData.imagePath),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/placeholder_image.png'); // Show a placeholder image on error
                  },
                )
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    classData.className,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // color: borderColor, // لون الحدود
                          border: Border.all(
                            color: borderColor, // لون الحدود
                            width: borderWidth, // سمك الحدود
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(classData.time),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // color: borderColor, // لون الحدود
                          border: Border.all(
                            color: borderColor, // لون الحدود
                            width: borderWidth, // سمك الحدود
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child:
                        Text(classData.date),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // color: borderColor, // لون الحدود
                          border: Border.all(
                            color: borderColor, // لون الحدود
                            width: borderWidth, // سمك الحدود
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child:
                        Text(classData.cost),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // color: borderColor, // لون الحدود
                          border: Border.all(
                            color: borderColor, // لون الحدود
                            width: borderWidth, // سمك الحدود
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(classData.coachName),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  LinearProgressIndicator(
                    value: subscribersCount / maxSubscribers,
                    valueColor: const AlwaysStoppedAnimation(Colors.green),
                    backgroundColor: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$subscribersCount / $maxSubscribers مشترك',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(classData.description),

                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Booking confirmation"),
                            content: const Text("Do you want to confirm the booking of this class"),
                            actions: [
                              TextButton(
                              onPressed: () async {
                            // Obtain the JWT token (replace with your actual token retrieval method)
                            final jwtToken = await getToken();
                            print("Token: $jwtToken");

                            final regBody = {
                              //'telephone': '123-456-7890',
                              'className': classData.className,
                              'cost': classData.cost,
                              'date': classData.date,
                              'time': classData.time,
                              'coachName': classData.coachName,
                            };

                            try {
                              final apiUrl = Uri.parse('http://192.168.111.1:3000/classBooking');

                              final response = await http.post(
                                apiUrl,
                                headers: {
                                  "Content-Type": "application/json",
                                  "Authorization": "Bearer $jwtToken", // Include the JWT token
                                },
                                body: jsonEncode(regBody),
                              );

                              if (response.statusCode == 200) {
                                // Handle booking success
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Booking Confirmation"),
                                      content: const Text("Failed to save the reservation to the database"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Close"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // Handle booking failure
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Booking Confirmation"),
                                      content: const Text(" Your reservation has been confirmed."),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Close"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            } catch (error) {
                              print('Error: $error');
                              // Handle network or other errors
                              // Display an error message to the user here
                            }
                          },
                          child: const Text("yes"),
                          ),

                          TextButton(
                                onPressed: () {
                                  // إغلاق النافذة عند النقر على "لا"
                                  Navigator.of(context).pop();
                                },
                                child: const Text("no"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                    ),
                    child: const Text('booking'),

                  ),


                ],

              ),
            ),
          ],
        ),
      ),
    );
  }


}
class ClassData {
  final String imagePath;
  final String className;
  final String time;
  final String date;
  final String cost;
  final String coachName;
  final int allowedNumber;
  final String description;

  ClassData({
    required this.imagePath,
    required this.className,
    required this.time,
    required this.date,
    required this.cost,
    required this.coachName,
    required this.allowedNumber,
    required this.description,
  });

  factory ClassData.fromJson(Map<String, dynamic> json) {
    return ClassData(
      imagePath: json['imagePath'],
      className: json['ClassName'],
      time: json['time'],
      date: json['Date'],
      cost: json['cost'],
      coachName: json['cotchName'],
      allowedNumber: json['allowedNumber'],
      description: json['description'],
    );
  }
}








class LinearProgressContainer extends StatelessWidget {
  final double value;
  final Color color;

  const LinearProgressContainer({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: LinearProgressIndicator(
        value: value,
        valueColor: AlwaysStoppedAnimation(color),
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}
