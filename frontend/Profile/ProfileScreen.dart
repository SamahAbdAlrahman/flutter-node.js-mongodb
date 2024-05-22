import 'package:flutter/material.dart';
import 'package:gofit/NetworkHandler.dart';
import 'package:gofit/Profile/MainProfile.dart';

import 'CreatProfile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    checkProfile();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    if (response["status"] == true) {
      setState(() {
        page = const MainProfile();
      });
    } else {
      setState(() {
        page = buildProfileButton();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: page,
      ),
    );
  }

  Widget buildProfileButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "You Don't Have a Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 19.5,fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatProfile()),
              )
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(  const Color.fromRGBO(246, 87, 14, 1.0)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),

            child: const Padding(

              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
              child: Text(
                "Create Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
