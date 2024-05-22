import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gofit/Blog/addBlog.dart';
import 'package:gofit/Coach/workoutEdit.dart';
import 'package:gofit/Screen/posts_view.dart';
import 'package:gofit/NetworkHandler.dart';
import 'package:gofit/Profile/ProfileScreen.dart';
import 'package:gofit/screens/login/on_boarding_view.dart';
import '../chat/group_chats/group_chat_screen.dart';
import '../screens/User/search.dart';
// import '../chat/search_chat.dart';

class MenuCoach extends StatefulWidget {
  const MenuCoach({super.key});

  @override
  _MenuCoachState createState() => _MenuCoachState();
}

class _MenuCoachState extends State<MenuCoach> {
  int currentState = 0;
  List<Widget> widgets = [const MenuCoach(), const ProfileScreen()];
  List<String> titleString = ["Coach Page", "Profile Page"];
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
  void navigateBasedOnSearch(String query) {
    if (query.toLowerCase().contains('exercises') || query.toLowerCase().contains('sport')  ||query.toLowerCase().contains('Workout') ||query.toLowerCase().contains('Training')) {
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => WorkoutTrackerView(),
      // ));
    } else if (query.toLowerCase().contains('tips') ) {
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => MealPlannerView(),
      // ));
    }  else if (query.toLowerCase().contains('bmi')) {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "New Story",
                style: TextStyle(
                  color: Color(0xff131e29), // لون النص
                ),
              ),
            )
            ,
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
              onTap: () {    Navigator.of(context)
                  .push(MaterialPageRoute
                (builder: (context) => const GroupChatHomeScreen())); },
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
        iconTheme: const IconThemeData(
          color: Colors.grey, // Set the color of the Drawer icon to grey
        ),
        backgroundColor:        Colors.white70,
        title: Text(
          titleString[currentState],
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 21,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[

          IconButton(icon: const Icon(Icons.chat_sharp    ,
            color: Colors.grey,),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) =>  GroupChatHomeScreen()));
              }),
        ],
      ),

       body:SafeArea(
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
                           0.000122,
                           0.678
                         ],
                         colors: [
                           Colors.black.withOpacity(1),
                           Colors.black.withOpacity(0.57)
                         ]),
                   ),
                   child: const Align(
                     alignment: Alignment.centerLeft,
                     child: Padding(
                       padding: EdgeInsets.all(29.0),
                       child: Text(
                         'you are in\n good hands\n with us',
                         style:
                         TextStyle(color: Colors.white38, fontFamily: ('inter'),fontSize: 24.6),
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
                       TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,
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

                           promoCardj('assets/images/n.jpg'),
                           // promoCardx('assets/images/X.jpg'),
                           // promoCardb('assets/images/b.jpg'),

                           promoCard3('assets/images/msg.jpg'),
                           promoCardq('assets/img/2.png'),
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
  Widget promoCardq(image) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => editExerciseView(),
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
                      'Add Exercises\nin Guest Page',
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
  Widget promoCard2(image) {
    return GestureDetector(
      onTap: () {
        // Navigate to RunningView when the promo card is tapped
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => WorkoutTrackerView(),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Add Exercises',
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
        // Navigator.of(context).push(
          // MaterialPageRoute(
          //   builder: (context) => MealPlannerView(),
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
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Add Tips',
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
  Widget promoCardl(image) {
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
