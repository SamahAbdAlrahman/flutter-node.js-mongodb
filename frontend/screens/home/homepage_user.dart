import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../Coach/workoutEdit.dart';
import '../../Blog/add.dart';
import '../../Blog/addBlog.dart';
import '../../NetworkHandler.dart';
import '../../Profile/ProfileScreen.dart';
import '../../Screen/posts_view.dart';

import '../../chat/group_chats/group_chat_screen.dart';
import '../../screens11/search_screen.dart';
import '../User/ExcerciseClasses.dart';
import '../User/UserExcercise.dart';
import '../User/search.dart';
import '../User/subscribtion.dart';
import '../User/workoutResult.dart';
import '../login/on_boarding_view.dart';
import '../meal_planner/meal_planner_view.dart';
import '../workout_tracker/exercise_view.dart';


class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int currentState = 0;
  List<Widget> widgets = [const MenuView(), const ProfileScreen()];
  // List<String> titleString = ["Home Page", "Profile Page"];
  final storage = const FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String username = "";
  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.deepOrange,
      borderRadius: BorderRadius.circular(50),
    ),
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    // super.initState();
    checkProfile();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response['username'];
    });
    if (response["status"] == true) {
      setState(() {
        profilePhoto = CircleAvatar(
          radius: 50,
          backgroundImage: NetworkHandler().getImage(response['username']),
        );
      });
    } else {
      setState(() {
        profilePhoto = Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      });
    }
  }
///
  ///
  void navigateBasedOnSearch(String query) {
    if (query.toLowerCase().contains('exercises') || query.toLowerCase().contains('sport')  ||query.toLowerCase().contains('Workout') ||query.toLowerCase().contains('Training')) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ExerciseView(),
      ));
    } else if (query.toLowerCase().contains('meals') || query.toLowerCase().contains('nutrition') || query.toLowerCase().contains('Diet')) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MealPlannerView(),
      ));
    } else if (query.toLowerCase().contains('booking')||query.toLowerCase().contains('book')) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SportsLessonsPage(),
      ));
    } else if (query.toLowerCase().contains('bmi')) {
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => BMIView(),
      // )
      // );
    } else if (query.toLowerCase().contains('bmr')) {
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => BMRView(),
      // )
      // );
    } else {
      // Handle other search cases or show a message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sorry !'),
            content: Text('This is not available with us.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  ///
  @override
  Widget build(BuildContext context) {

    // to get size
    var size = MediaQuery.of(context).size;


    // style
    var cardTextStyle = const TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      drawer: Drawer(

        child: ListView(

          children: <Widget>[

            DrawerHeader(
              child: Column(

                children: <Widget>[
                  profilePhoto,
                  const SizedBox(
                    height: 10,
                  ),
                  Text(username,
                      style: TextStyle(color: AppColor.bgSideMenu)),
                ],
              ),
            ),
            ListTile(
              title: Text(
                "My Account",
                style: TextStyle(
                  color: AppColor.bgSideMenu, // لون النص
                ),
              ),
              leading: const Icon(Icons.person
                , color:Color(0xff131e29) , size: 16,), // لون الأيقونة
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const ProfileScreen(),));
                // Blogs
              },
            ),
            ListTile(
              leading: const Icon(Icons.search, color: Color(0xff131e29) , size: 16,), // لون الأيقونة
              title: Text(
                "Search",
                style: TextStyle(
                  color: Color(0xff131e29), // لون النص
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const SearchPage(),));
                // Blogs
              },
            ),
            ListTile(
              leading: const Icon(Icons.track_changes_sharp,color: Color(0xff131e29), size: 16,),
              title: const Text("Fitness tracker"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) =>  workout(),));
                // Blogs
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.subject_sharp,
                // Icons.work_outline_outlined,
                color: Color(0xff131e29), size: 16,),
              title: const Text("my Subscribtion"),


            ),
            ListTile(
              leading: const Icon(Icons.launch, color: Color(0xff131e29), size: 16,), // لون الأيقونة
              title: Text(
                "All Posts",
                style: TextStyle(
                  color: Color(0xff131e29), // لون النص
                ),
              ),
              // icon:"Icons.launch",
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const PostsView(),));
                // Blogs
              },
            ),

            ListTile(
              leading: const Icon(Icons.add, color: Color(0xff131e29), size: 16,), // لون الأيقونة
              title: Text(
                "New Post",
                style: TextStyle(
                  color: Color(0xff131e29), // لون النص
                ),
              ),
              onTap: () {    Navigator.of(context)
                  .push(MaterialPageRoute
                (builder: (context) => const AddBlog())); },
            ),
            ListTile(
              leading: const Icon(Icons.chat_bubble, color: Color(0xff131e29), size: 16,), // لون الأيقونة
              title: Text(
                "New Chat",
                style: TextStyle(
                  color: Color(0xff131e29), // لون النص
                ),
              ),
              onTap: () {
                Navigator.of(context)
                  .push(MaterialPageRoute
                (builder: (context) => const GroupChatHomeScreen()));
                },
            ),

            ListTile(
              leading: const Icon(Icons.settings,   color: Color(0xff131e29), size: 16,), // لون الأيقونة
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Color(0xff131e29), // لون النص
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.feedback,   color: Color(0xff131e29), size: 16,), // لون الأيقونة
              title: Text(
                "Feedback",
                style: TextStyle(
                  color: Color(0xff131e29),// لون النص
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded,   color: Color(0xff131e29), size: 16,), // لون الأيقونة
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Color(0xff131e29), // لون النص
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey, // لون الأيقونة
        ),
        // brightness: Brightness.light,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.menu,
        //     color: Colors.black87,
        //   ),
        //   onPressed: () {},
        // ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Find Your',
                      style: TextStyle(color: Colors.black87,
                          fontFamily: ('inter'), fontSize: 25),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Inspiration',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                      ,
                        fontFamily: ('inter'),),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 243, 243, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        onSubmitted: (query) {
                          navigateBasedOnSearch(query);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black87,
                            ),
                            hintText: "Search you're looking for",
                            hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 15)),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
              //

              Container(
                width: 412,
                height: 165,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/11.png')),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        // stops: [
                        //   0.022,
                        //   0
                        // ],
                        // colors: [
                        //   Colors.black.withOpacity(1),
                        //   Colors.black.withOpacity(0.8)
                        // ]),
                        stops: [
                          0.0,
                          0
                        ],
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.black.withOpacity(0.599)
                        ]),
                  ),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(29.0),
                      child: Text(
                        'you are in\n good hands\n with us',
                        style:
                        TextStyle(color: Colors.white60, fontFamily: ('inter'),fontSize: 24.6),
                      ),
                    ),
                  ),
                ),
              ),

              //
              SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Categories',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold ,
                      color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          promoCard2('assets/img/2.png'),
                          promoCardj('assets/images/j.jpg'),
                          promoCardl('assets/images/l.jpg'),
                          promoCardx('assets/images/X.jpg'),
                          promoCardb('assets/images/b.jpg'),

                          promoCard3('assets/images/msg.jpg'),

                          promoCard5('assets/images/q.jpg'),

                          promoCard4('assets/images/w.jpg'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),


    );
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingView()),
            (route) => false);
  }

  Widget promoCard2(image) {
    return GestureDetector(
      onTap: () {
        // Navigate to RunningView when the promo card is tapped
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => userExercise(),
          ),
        );
      },
      child:  AspectRatio(
        aspectRatio: 2.62 / 3,
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                  0.1,
                  0.9
                ], colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.1)
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Exercises',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget promoCardj(image) {
    return GestureDetector(
      onTap: () {
        // Navigate to RunningView when the promo card is tapped
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SearchScreen(),
          ),
        );
      },
      child:  AspectRatio(
        aspectRatio: 2.62 / 3,
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                  0.1,
                  0.9
                ], colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.1)
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Meal Plans',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget promoCardl(image) {
    return GestureDetector(
      onTap: () {
        // Navigate to RunningView when the promo card is tapped
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SportsLessonsPage(),
          ),
        );
      },
      child:  AspectRatio(
        aspectRatio: 2.62 / 3,
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                  0.1,
                  0.9
                ], colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.1)
                ])),
            child: Column(
  mainAxisAlignment: MainAxisAlignment.end,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Align(
  alignment: Alignment.bottomLeft,
  child: Padding(
  padding: EdgeInsets.all(8.0),
  child: Text(
  'Booking',
  style: TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  ),
  ),
  ),
  ),
  ],
  ),
  ),
  ),
  ),
  );
}
Widget promoCardx(image) {
    return GestureDetector(
      onTap: () {
        // Navigate to RunningView when the promo card is tapped
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     // builder: (context) => RunningView(),
        //   ),
        // );
      },
      child:  AspectRatio(
        aspectRatio: 2.62 / 3,
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                  0.1,
                  0.9
                ], colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.1)
                ])),

          ),
        ),
      ),
    );
}
  Widget promoCardb(image) {
    return GestureDetector(
        onTap: () {
      // Navigate to RunningView when the promo card is tapped
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     // builder: (context) => RunningView(),
      //   ),
      // );
    },
    child:  AspectRatio(
      aspectRatio: 2.62 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                0.1,
                0.9
              ], colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.1)
              ])),
        ),
      ),
    ),
    );
  }
  Widget promoCard3(image) {
    return GestureDetector(
      onTap: () {
        // Navigate to RunningView when the promo card is tapped
        // Navigator.of(context).push(
        // MaterialPageRoute(
        //   builder: (context) => SportsLessonsPage(),
        // ),
        // );
      },
      child:  AspectRatio(
        aspectRatio: 2.62 / 3,
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                  0.1,
                  0.9
                ], colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.1)
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                      'Chat',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget promoCard4(image) {
    return GestureDetector(
      onTap: () {
        // Navigate to RunningView when the promo card is tapped
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     // builder: (context) => RunningView(),
        //   ),
        // );
      },
      child:  AspectRatio(
        aspectRatio: 2.62 / 3,
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                  0.1,
                  0.9
                ], colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.4)
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'New Post',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget promoCard5(image) {
    return GestureDetector(
      onTap: () {
        // Navigate to RunningView when the promo card is tapped
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     // builder: (context) => RunningView(),
        //   ),
        // );
      },
      child:  AspectRatio(
        aspectRatio: 2.62 / 3,
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                  0.1,
                  0.9
                ], colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(.41)
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'View All Posts',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

class AppColor {
  static Color bgSideMenu = Color(0xff131e29);
}



