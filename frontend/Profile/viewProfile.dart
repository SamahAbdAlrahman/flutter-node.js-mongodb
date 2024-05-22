import 'package:gofit/Blog/Blogs.dart';
import 'package:gofit/Model/profileModel.dart';
import 'package:gofit/NetworkHandler.dart';
import 'package:flutter/material.dart';
import '../screens/home/homepage_user.dart';

class MainProfile1 extends StatefulWidget {
  final String username;

  const MainProfile1({super.key, required this.username});

  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile1> {
  Widget currentTab = const MenuView();
  int currentState = 0;
  // List<String> titleString = ["Home Page", "Profile Page"];
  bool circular = true;

  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel(
      DOB: '_dob',
      about: '_about',
      name: '_name',
      profession: '_profession',
      titleline: '_title');

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {

    var response = await networkHandler.get("/profile/getData/${widget.username}");

    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey, // Set the color of the Drawer icon to grey
        ),
        backgroundColor: Colors.white,
        // title: Text(titleString[currentState]),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.notifications,
            color: Colors.grey,),
              onPressed: () {}),
          IconButton(icon: const Icon(Icons.messenger,
            color: Colors.grey,),
              onPressed: () {}),

        ],
      ),
      backgroundColor: Colors.white,


      body: circular
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        children: <Widget>[

          head(),

          const SizedBox(height: 40),
          const Divider(
            thickness: 1.3,
          ),
          otherDetails(" Name ", profileModel.name),

          const Divider(
            thickness: 0.5,
          ),
          otherDetails("About  ", profileModel.about),
          const Divider(
            thickness: 0.5,
          ),
          otherDetails("Date of Birth ", profileModel.DOB),
          const Divider(
            thickness: 0.5,
          ),
          otherDetails("Education ", profileModel.profession),
          // Divider(
          //   thickness: 1,
          // ),
          const SizedBox(height: 159),
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              " Posts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          )
          ,
          const SizedBox(height: 50),
          const Blogs(
            url: "/blogpost/getOwnBlog",
          ),
        ],
      ),
    );
  }

  Widget head() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // SizedBox(
          //   height: 10,
          // ),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkHandler().getImage(
                  profileModel.username as String),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Text(
            profileModel.username as String,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500
                , color: Colors.black87),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(profileModel.titleline),
        ],
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label ",
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400, color: Color.fromRGBO(
                255, 77, 0, 1.0),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 15,
              fontWeight: FontWeight.w400, color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }




}

