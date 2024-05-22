import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:gofit/screens/home/homepage_user.dart';
import 'package:gofit/webchat/group_chats/group_chat_screen.dart';

// import '../../Admin/workoutEdit.dart';

import '../../Blog/addBlog.dart';
import '../../NetworkHandler.dart';
import '../../Profile/ProfileScreen.dart';
import '../../Screen/posts_view.dart';

import '../../WelcomeScreen.dart';
import '../../chat/group_chats/group_chat_screen.dart';
import '../../common/app_colors.dart';
import '../../screens11/search_screen.dart';


// import 'package:google_fonts/google_fonts.dart';

class MenuView2 extends StatefulWidget {
  // LoginScreen({Key? key}) : super(key: key);
  @override
  _MenuViewState createState() => _MenuViewState();
}
class _MenuViewState extends State<MenuView2> {
  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            (route) => false);
  }
  int currentState = 0;
  List<Widget> widgets = [ MenuView(), const ProfileScreen()];
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
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
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
                  style: TextStyle(color: Color(0xff131e29))),
                ],
              ),
            ),
            ListTile(
              title: Text(
                "My Account",
                style: TextStyle(
                  color: Color(0xff131e29), // لون النص
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
              // onTap: () {
              //   Navigator.of(context)
              //       .push(MaterialPageRoute(builder: (context) => const SearchPage(),));
              //   // Blogs
              // },
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
              // chatweb
              leading: const Icon(Icons.chat_bubble, color: Color(0xff131e29), size: 16,), // لون الأيقونة
              title: Text(
                "New Chat",
                style: TextStyle(
                  color: Color(0xff131e29), // لون النص
                ),
              ),
              onTap: () {    Navigator.of(context)
                  .push(MaterialPageRoute
                (builder: (context) => const chatweb())); },
            ), ListTile(
              leading: const Icon(Icons.track_changes, color: Color(0xff131e29), size: 16,), // لون الأيقونة
              title: Text(
                "track",
                style: TextStyle(
                  color: Color(0xff131e29), // لون النص
                ),
              ),
              // onTap: ()
              // {    Navigator.of(context)
              //     .push(MaterialPageRoute
              //   (builder: (context) => workout())); },
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
        backgroundColor: Color(0x83d9d8d8),
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
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          Menu(),
          Body(),
          Container(
            height: 390,
            // height: 320,
            width: MediaQuery.of(context).size.width,
            // width: 400,
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

          // YourDrawer(),
        ],
      ),
    );
  }
  Widget promoCard2(image) {
    return GestureDetector(
      onTap: () {
        // // Navigate to RunningView white70en the promo card is tapped
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => userExercise(),
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
                        color: Colors.white,
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
      // onTap: () {
      //   // Navigate to RunningView when the promo card is tapped
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => SportsLessonsPage(),
      //     ),
      //   );
      // },
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



class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // _menuItem(// add icone here for drawer),
              _menuItem(title: 'Home'),
              _menuItem(title: 'About us'),
              _menuItem(title: 'Contact us'),
              _menuItem(title: 'Help'),
            ],
          ),
          // Row(
          //   children: [
          //     // _menuItem(title: 'Sign UP', isActive: true),
          //     _registerButton(context),
          //
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _menuItem({String title = 'Title Menu', isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.deepOrange : Colors.grey,
              ),
            ),
            // SizedBox(
            //   height: 6,
            // ),
            isActive
                ? Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(30),
              ),
            )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 3,
            blurRadius: 9,
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          // Navigate to NewAccountScreen
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => LoginScreen()),
          // );
        },
        child: Text(
          'Register',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );

  }
}

class Body extends StatelessWidget {

  // Body({});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0,
              ),
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
                    color: Color.fromRGBO(237, 237, 237, 1.0),
                    // color: Color.fromRGBO(244, 243, 243, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  // onSubmitted: (query) {
                  //   navigateBasedOnSearch(query);
                  // },
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
              // Row(
              //   children: [
              //     Text(
              //       "You can",
              //       style: TextStyle(
              //           fontSize: 16,
              //           color: Colors.black54, fontWeight: FontWeight.bold),
              //     ),
              //     SizedBox(width: 6),
              //     GestureDetector(
              //       onTap: () {
              //         print(MediaQuery.of(context).size.width);
              //       },
              //       child: Text(
              //         "Register here!",
              //         style: TextStyle(
              //             color: Colors.deepOrange,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ],
              // ),
              // Image.asset(
              //   'assets/img/ggg.png',
              //   width: 300,
              // ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),

        )
      ],
    );
  }

}

class YourDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'inter',
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text("Create Account"),
            trailing: const Icon(Icons.account_circle_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Login"),
            trailing: const Icon(Icons.login_sharp),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Settings"),
            trailing: const Icon(Icons.settings),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Feedback"),
            trailing: const Icon(Icons.feedback),
            onTap: () {
              // Handle Feedback
            },
          ),
          ListTile(
            title: const Text("Logout"),
            trailing: const Icon(Icons.power_settings_new),
            onTap: () {
              // Handle Logout
            },
          ),
        ],
      ),
    );
  }
}