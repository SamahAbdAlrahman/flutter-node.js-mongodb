//
// import 'package:flutter/material.dart';
// import 'package:gofit/screens/meal_planner/meal_planner_view.dart';
// import 'package:gofit/screens/workout_tracker/workout_tracker_view.dart';
//
// import '../../WelcomeScreen.dart';
// import '../login/on_boarding_view.dart';
//
// class SelectView2 extends StatelessWidget {
//   const SelectView2({super.key});
//   void navigateBasedOnSearch(String query) {
//     if (query.toLowerCase().contains('exercises') || query.toLowerCase().contains('sport')  ||query.toLowerCase().contains('Workout') ||query.toLowerCase().contains('Training')) {
//       MaterialPageRoute(
//         builder: (context) => WorkoutTrackerView(),
//       );
//     } else if (query.toLowerCase().contains('meals') || query.toLowerCase().contains('nutrition') || query.toLowerCase().contains('Diet')) {
//       MaterialPageRoute(
//         builder: (context) => WorkoutTrackerView(),
//       );
//     } else if (query.toLowerCase().contains('tips')) {
//       MaterialPageRoute(
//         builder: (context) => WorkoutTrackerView(),
//       );
//     } else if (query.toLowerCase().contains('bmi')) {
//       MaterialPageRoute(
//         builder: (context) => WorkoutTrackerView(),
//       );
//     } else if (query.toLowerCase().contains('bmr')) {
//       MaterialPageRoute(
//         builder: (context) => WorkoutTrackerView(),
//       );
//     } else {
//
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 243, 243, 1),
//       drawer: Drawer(
//         child: ListView(
//           children: <Widget>[
//             DrawerHeader(
//               child: Column(
//                 children: <Widget>[
//
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   Text('Welcome',
//                     style:
//                   TextStyle(color: Colors.black87,
//                       fontFamily: ('inter'), fontSize: 25
//                   ),
//                   ),
//                   const SizedBox(
//                     height: 0,
//                   ),
//                 ],
//               ),
//             ),
//
//             ListTile(
//               title: const Text("Create Account"),
//               trailing: const Icon(Icons.account_circle_outlined),
//               onTap: () {},
//             ),
//             ListTile(
//               title: const Text("Login"),
//               trailing: const Icon(Icons.login_sharp),
//               onTap: () {},
//             ),
//             ListTile(
//               title: const Text("Settings"),
//               trailing: const Icon(Icons.settings),
//               onTap: () {},
//             ),
//             ListTile(
//               title: const Text("Feedback"),
//               trailing: const Icon(Icons.feedback),
//               onTap: () {
//                 // HomeScreen
//               },
//             ),
//
//             ListTile(
//               title: const Text("Logout"),
//               // trailing: const Icon(Icons.logout_sharp),
//               trailing: const Icon(Icons.power_settings_new),
//               onTap: logout,
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//
//       ),
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius:
//                     BorderRadius.vertical(bottom: Radius.circular(30))),
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'Welcome',
//                       style: TextStyle(color: Colors.black87,
//                           fontFamily: ('inter'), fontSize: 25),
//                     ),
//                     Text(
//                       'Sign up!',
//                       style: TextStyle(color: Colors.black87,
//                           fontFamily: ('inter'), fontSize: 25 ,
//                         fontWeight: FontWeight.bold,),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       'to enjoy all our services',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         // fontWeight: FontWeight.bold,
//
//                         fontFamily: ('inter'),),
//                     ),
//                     SizedBox(
//                       height: 22,
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                           color: Color.fromRGBO(244, 243, 243, 1),
//                           borderRadius: BorderRadius.circular(15)),
//                       child: TextField(
//                         onSubmitted: (query) {
//                           navigateBasedOnSearch(query);
//                         },
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             prefixIcon: Icon(
//                               Icons.search,
//                               color: Colors.black87,
//                             ),
//                             hintText: "Search you're looking for",
//                             hintStyle:
//                             TextStyle(color: Colors.grey, fontSize: 15)),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//               //
//
//
//               //
//               SizedBox(
//                 height: 22,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
//            // const EdgeInsets.symmetric(),
//                 child: Column(
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       ' Categories',
//                       style:
//                       TextStyle(fontSize: 16.7,
//                           fontWeight: FontWeight.bold ,
//                           color: Colors.blueGrey),
//                     ),
//                     SizedBox(
//                       height: 22,
//                     ),
//                     Container(
//                       height: 320,
//                       width: 400,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: <Widget>[
//                           promoCard5('assets/images/n.jpg'),
//                           promoCard4('assets/img/7.png'),
//                           promoCard3('assets/images/f.jpg'),
//                           promoCard2('assets/images/X.jpg'),
//                           promoCard1('assets/images/b.jpg'),
//
//
//
//
//
//
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//
//                   ],
//                 ),
//               )   ,
//             ],
//           ),
//         ),
//       ),
//
//
//
//     );
//
//   }
//   void logout() async {
//     // await storage.delete(key: "token");
//
//     MaterialPageRoute(builder: (context) => const WelcomeScreen());
//   }
//   Widget promoCard1(image) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to RunningView when the promo card is tapped
//         // Navigator.of(context).push(
//         //   MaterialPageRoute(
//         //     // builder: (context) => RunningView(),
//         //   ),
//         // );
//       },
//       child:  AspectRatio(
//         aspectRatio: 2.62 / 3,
//         child: Container(
//           margin: EdgeInsets.only(right: 15.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
//                   0.1,
//                   0.9
//                 ], colors: [
//                   Colors.black.withOpacity(.8),
//                   Colors.black.withOpacity(.1)
//                 ])),
//
//           ),
//         ),
//       ),
//     );
//   }
//   Widget promoCard2(image) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to RunningView when the promo card is tapped
//         // Navigator.of(context).push(
//         //   MaterialPageRoute(
//         //     // builder: (context) => RunningView(),
//         //   ),
//         // );
//       },
//       child:  AspectRatio(
//         aspectRatio: 2.62 / 3,
//         child: Container(
//           margin: EdgeInsets.only(right: 15.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
//                   0.1,
//                   0.9
//                 ], colors: [
//                   Colors.black.withOpacity(.8),
//                   Colors.black.withOpacity(.1)
//                 ])),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget promoCard3(image) {
//     return GestureDetector(
//       onTap: () {
//
//           MaterialPageRoute(
//             builder: (context) =>  const MealPlannerView(),
//
//         );
//       },
//       child:  AspectRatio(
//         aspectRatio: 2.62 / 3,
//         child: Container(
//           margin: EdgeInsets.only(right: 15.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
//                   0.1,
//                   0.9
//                 ], colors: [
//                   Colors.black.withOpacity(.8),
//                   Colors.black.withOpacity(.421)
//                 ])),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Padding(
//                     padding: EdgeInsets.all(9.0),
//                     child: Text(
//                       '  Meal Plans',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 17.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget promoCard4(image) {
//     return GestureDetector(
//       onTap: () {
//
//           MaterialPageRoute(
//             builder: (context) =>  const WorkoutTrackerView(),
//
//         );
//       },
//       child:  AspectRatio(
//         aspectRatio: 2.62 / 3,
//         child: Container(
//           margin: EdgeInsets.only(right: 15.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
//                   0.1,
//                   0.9
//                 ], colors: [
//                   Colors.black.withOpacity(.9),
//                   Colors.black.withOpacity(.4)
//                 ])),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       '  Gymnastics',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget promoCard5(image) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to RunningView when the promo card is tapped
//         // Navigator.of(context).push(
//         //   MaterialPageRoute(
//         //     // builder: (context) => RunningView(),
//         //   ),
//         // );
//       },
//       child:  AspectRatio(
//         aspectRatio: 2.62 / 3,
//         child: Container(
//           margin: EdgeInsets.only(right: 15.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
//                   0.1,
//                   0.9
//                 ], colors: [
//                   Colors.black.withOpacity(.9),
//                   Colors.black.withOpacity(.4)
//                 ])),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       '  Tips',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
