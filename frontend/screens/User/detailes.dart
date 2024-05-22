import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'countdown-page.dart';

class detailes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('Details'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ExercisePage(),
      ),
    );
  }
}

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {


  @override

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16.0),

        // Image at the top
        Image.asset(
          'assets/img/Push.gif',
          height: 200.0,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 16.0),
        Text(
          'Do it in 10 mins ⏰ to Burning 400 calories🔥',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),

        Divider(
          thickness: 2.0,
          color: Colors.grey,
          indent: 18.0,
          endIndent: 16.0,
        ),

        // Description in the middle
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'To do a push-up you are going to get on the floor on all fours, positioning your hands slightly wider than your shoulders. Dont lock out the elbows; keep them slightly bent. Extend your legs back so you are balanced on your hands and toes, your feet hip-width apart. Once in this position, here is how you will do a push-up.',
            style: TextStyle(fontSize: 16.0, color: Colors.black38),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 16.0),

        // Buttons at the bottom
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CountdownPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
              ),              child: Text('Use Timer⏰'),
            ),

            ElevatedButton(
              onPressed: () async {
                final jwtToken = await getToken();
                print("Token: $jwtToken");

                final regBody = {
                  'ExcerciseName': 'Push-up', // Replace with the actual exercise name
                  'time': '10 ', // Replace with the actual exercise time
                  'Calories': '400', // Replace with the actual calories burned
                };

                try {
                  final apiUrl = Uri.parse('http://192.168.111.1:3000/addWorkout');

                  final response = await http.post(
                    apiUrl,
                    headers: {
                      "Content-Type": "application/json",
                      "Authorization": "Bearer $jwtToken",
                    },
                    body: jsonEncode(regBody),
                  );

                  if (response.statusCode == 201) {
                    // Handle successful response
                    print('Exercise data saved successfully!');
                    contentBox(context) {
                      return Center(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset('assets/img/true.gif', height: 100, width: 100),
                                  Text(' Well Done , Great Job', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                                    ),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: contentBox(context),
                        );
                      },
                    );



                  } else {
                    // Handle failure response
                    print('Failed to save exercise data');
                  }
                } catch (error) {
                  print('Error: $error');
                  // Handle network or other errors
                }
               // Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
              ),
              child: Text(
                'Done Exercise',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),



          ],
        ),

        SizedBox(height: 16.0),

        // Display the timer value

      ],
    );
  }
}
