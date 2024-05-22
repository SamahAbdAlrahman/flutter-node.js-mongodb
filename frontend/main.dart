import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gofit/screens/User/UserExcercise.dart';
import 'package:gofit/screens/User/workoutResult.dart';
import 'package:gofit/screens/home/homepage_user.dart';
import 'package:gofit/screens/home/running_view.dart';
import 'package:gofit/screens/login/login_screen.dart';
import 'package:gofit/screens/login/on_boarding_view.dart';
import 'package:gofit/screens/login/signup_screen.dart';
import 'package:gofit/screens/login/step1_view.dart';
import 'package:gofit/screens/main_tab/main_tab_view.dart';
import 'package:gofit/screens/main_tab/select_view.dart';
import 'package:gofit/screens/main_tab/u.dart';
import 'package:gofit/screens/workout_tracker/AdvancedExercises.dart';
import 'package:gofit/screens/workout_tracker/BeginnerExercises.dart';
import 'package:gofit/screens/workout_tracker/IntermediateExercises.dart';
import 'package:gofit/screens/workout_tracker/exercise_view.dart';
import 'package:gofit/screens/workout_tracker/workout_detail_view.dart';
import 'package:gofit/screens11/search_screen.dart';

import 'Coach/MenuCoach.dart';
import 'Coach/editAdvancedExercises.dart';
import 'Coach/workoutEdit.dart';
import 'Nutritionist/AddMeal/explore.dart';
import 'WelcomeScreen.dart';
import 'login_screen.dart';
import 'meal_design/explore.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(
    // name: "gofit",
    options:
    // const FirebaseOptions(
    //   apiKey:"AIzaSyBG_BAM8Vn9ykEcGyeaJOSWKT0v7ZPLPp8",
    //   appId: "1:190300387010:android:9e6f18f516269215936d5b",
    //   messagingSenderId: "190300387010",
    //   projectId: "test-1143b",
    //
    // ),
      const FirebaseOptions(
      apiKey:"AIzaSyCPd-z6TzVPVUNb3McLpjAyW4Hm5N3S0M0",
      appId: "1:686896024591:android:7726da39e1c577f39ee77a",
      messagingSenderId:"686896024591",
      projectId:"finial-e65c4",

    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   fontFamily: ('inter'),
      //   useMaterial3: true,
      // ),
        theme: ThemeData(
        fontFamily: "Quicksand",
        // colorScheme: ColorScheme.fromSeed(seedColor: TColor.primary),
        useMaterial3: false,
      ),
      // home: NewAccountScreen(),
      // home: MainTabView(),
      // home: WelcomeScreen(),
      // home: SelectView(),
      // home: Explore(),
      // home: SearchScreen(),

      // home :NewAccountScreen(),
      // home :LoginScreen(),
      home :LoginScreenweb(),
      // home :addExplore(),
      // home :Explore(),
      // home :addExplore(),
    );
  }
}
