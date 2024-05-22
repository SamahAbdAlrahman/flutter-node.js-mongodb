import 'package:gofit/Screen/posts_view.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gofit/NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Profile/ProfileScreen.dart';
import '../screens/login/on_boarding_view.dart';
//////////////////////////////////////////// for user
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentState = 0;
  List<Widget> widgets = [const PostsView(), const ProfileScreen()];
  List<String> titleString = ["Home Page", "Profile Page"];
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
    // TODO: implement initState
    super.initState();
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
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      });
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
                  Text(username),
                ],
              ),
            ),
            ListTile(
              title: const Text("All Post"),
              trailing: const Icon(Icons.launch),
              onTap: () {},
            ),
            ListTile(
              title: const Text("New Story"),
              trailing: const Icon(Icons.add),
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
              onTap: () {},
            ),
            ListTile(
              title: const Text("Logout"),
              trailing: const Icon(Icons.power_settings_new),
              onTap: logout,
            ),
          ],
        ),
      ),
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //     color: Colors.grey, // Set the color of the Drawer icon to grey
      //   ),
      //   backgroundColor:        Colors.white,
      //   title: Text(titleString[currentState]),
      //   centerTitle: true,
      //   actions: <Widget>[
      //     IconButton(icon: Icon(Icons.notifications    ,
      //       color: Colors.grey,),
      //         onPressed: () {}),
      //   ],
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor:
      //   // Color.fromRGBO(248, 96, 2, 1.0),
      //   Color.fromRGBO(24, 24, 23, 1.0),
      //         onPressed: () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (context) => AddBlog()));
      //   },
      //   child: Text(
      //     "+",
      //     style: TextStyle(fontSize: 40),
      //   ),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   color:       Color.fromRGBO(24, 24, 23, 1.0),
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 12,
      //   child: Container(
      //     height: 60,
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: <Widget>[
      //           IconButton(
      //             icon: Icon(Icons.home),
      //             color: currentState == 0 ? Colors.white : Colors.white54,
      //             onPressed: () {
      //               setState(() {
      //                 currentState = 0;
      //               });
      //             },
      //             iconSize: 40,
      //           ),
      //           IconButton(
      //             icon: Icon(Icons.person),
      //             color: currentState == 1 ? Colors.white : Colors.white54,
      //             onPressed: () {
      //               setState(() {
      //                 currentState = 1;
      //               });
      //             },
      //             iconSize: 40,
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: widgets[currentState],
    );
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingView()),
            (route) => false);
  }
}
