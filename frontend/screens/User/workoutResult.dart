import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/profileModel.dart';
import '../../NetworkHandler.dart';
import '../../Profile/viewProfile.dart';

class ExerciseData {
  final int exerciseCount;
  final int timeSum;
  final int caloriesSum;

  ExerciseData({
    required this.exerciseCount,
    required this.timeSum,
    required this.caloriesSum,
  });
}



class workout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('User Workout', style:GoogleFonts.acme(textStyle:TextStyle(fontSize: 22,fontWeight: FontWeight.bold,))
    ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ExerciseStatsPage(),
      ),
    );
  }
}

class ExerciseStatsPage extends StatefulWidget {
  @override
  _ExerciseStatsPageState createState() => _ExerciseStatsPageState();
}

class _ExerciseStatsPageState extends State<ExerciseStatsPage> {
  late Future<int> exerciseCount;
  late Future<int> timeSum;
  late Future<int> caloriesSum;

  late Future<List<Map<String, dynamic>>> experts;

  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel(DOB: '_dob',
      about: '_about',
      name: '_name',
      profession: '_profession',
      titleline: '_title');
  bool circular = true;

  @override
  void initState() {
    super.initState();
    exerciseCount = fetchExerciseCount();
    timeSum = fetchTimeSum();
    caloriesSum = fetchCaloriesSum();
    fetchData();
   // getUserId();
    // Fetch experts
    getUserId().then((studentId) {
      if (studentId != null) {
        experts = fetchExperts(studentId);
      }
    });
  }
  void fetchData() async {
    var response = await networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
  }
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<int> fetchExerciseCount() async {
    final jwtToken = await getToken();
    try {
      final apiUrl = Uri.parse('http://192.168.0.105:5000/getWorkout-Count');
      final response = await http.get(
        apiUrl,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        print(jsonData['count']);
        return jsonData['count'];
      } else {
        throw Exception('Failed to load user count');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load user count');
    }
  }

  Future<int> fetchTimeSum() async {
    final jwtToken = await getToken();
    try {
      final apiUrl = Uri.parse('http://192.168.0.105:5000/getWorkout-Time');
      final response = await http.get(
        apiUrl,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        print(jsonData['sumOfTime']);
        return jsonData['sumOfTime'];
      } else {
        throw Exception('Failed to load user count');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load user count');
    }
  }

  Future<int> fetchCaloriesSum() async {
    final jwtToken = await getToken();
    try {
      final apiUrl = Uri.parse('http://192.168.0.105:5000/getWorkout-calories');
      final response = await http.get(
        apiUrl,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        print("***********************************************"+jsonData['sumOfcalories']
        +"*****************************");

        return jsonData['sumOfcalories'];
      } else {
        throw Exception('Failed to load user count');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load user count');
    }
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      // Handle the case where the token is not available
      return null;
    }

    final apiUrl = Uri.parse('http://192.168.0.105:5000/profile/getuserId'); // Replace with your actual API base URL
    final response = await http.get(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String objectId = data['objectId'];
      print(objectId);

      return objectId;
    } else {
      // Handle the error case
      print('Error: ${response.statusCode}');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchExperts(String studentId) async {
    final String baseUrl = 'http://192.168.0.105:5000';
    final String endpoint = '/ai/$studentId';

    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> experts = List.from(data['experts']);
        return experts;
      } else if (response.statusCode == 404) {
        throw Exception('Recommendations not found');
      } else {
        throw Exception('Failed to retrieve recommendations and expert information');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    final id=  getUserId();

    return FutureBuilder(
      future: Future.wait([exerciseCount, timeSum, caloriesSum]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<int> data = snapshot.data as List<int>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child:Column(
              children: [
                Row(children: [
              SizedBox(width: 20),


                  // Display profile image
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkHandler().getImage(
                    profileModel.username as String),
              ),
                  SizedBox(width: 20),

                  Text(
                    profileModel.name ?? "",
                    style:GoogleFonts.acme(textStyle:TextStyle(fontSize: 22,fontWeight: FontWeight.bold,)

                    ),)

              // Display profile name

                ],),
                SizedBox(height: 30),

                Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(width: 15,),
                // Container for exercise count in the top-left corner
                Container(
                  width: 120,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children:[
                      SizedBox(height: 15,),

                      Text(
                        'Finshed 💪',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '\n${data[0]}',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 35),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Completed Excercise',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
                        textAlign: TextAlign.center,
                      ),

              ],
                  ),

                ),
                SizedBox(width: 16), // Spacer between the containers

                // Containers for time sum and calories sum on the right
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Text(
                            'Time spent ⏰',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                            Text(
                              '\n${data[1]}    minutes',
                              style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                    ],
                        ),
                      ),
                      SizedBox(height: 16), // Spacer between the containers
                      Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),

                            Text(
                            'Calories burned 🔥',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                            Text(
                              '\n${data[2]}   kcal',
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                        ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

                SizedBox(height: 50),
                FutureBuilder(
                  future: experts,
                  builder: (context, expertSnapshot) {
                    if (expertSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (expertSnapshot.hasError) {
                      return Center(
                          child: Text(''));
                    } else {
                      final List<Map<String, dynamic>> expertData =
                      expertSnapshot.data
                      as List<Map<String, dynamic>>;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                        'Recomendation Coach:', // Add your desired text here
                            style:GoogleFonts.acme(textStyle:TextStyle(fontSize: 22,fontWeight: FontWeight.bold,)
                            )
                      ),
                    SizedBox(height: 10),


                       SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                       child: Row(
                         children: expertData
                             .map(
                               (expert) => GestureDetector(
                             onTap: () {

                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => MainProfile1(
                                     // Pass user information to the ProfileScreen
                                     username: expert['username'],

                                   ),
                                 ),
                               );
                               // Define the action when the button is tapped
                               // For example, you can navigate to a new screen
                               // or perform some other action
                               print('Button tapped for ${expert['name']}');
                             },
                             child: Container(
                               width: 120,
                               height: 150,
                               margin: EdgeInsets.all(8),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(12),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey.withOpacity(1),
                                     spreadRadius: 2,
                                     blurRadius: 5,
                                     offset: Offset(0, 3),
                                   ),
                                 ],
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   CircleAvatar(
                                     radius: 35,
                                     backgroundImage: NetworkHandler()
                                         .getImage(expert['username'] as String),
                                   ),
                                   SizedBox(height: 8),
                                   Text(
                                     expert['name'] as String,
                                     textAlign: TextAlign.center,

                                     style:GoogleFonts.acme(textStyle:TextStyle(fontSize: 16,fontWeight: FontWeight.w600,)
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         )
                             .toList(),
                       ),
                     ),
                    ],);
                    }
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

