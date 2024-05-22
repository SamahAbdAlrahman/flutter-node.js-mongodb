import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:gofit/Blog/Blogs.dart';
import 'package:gofit/Model/profileModel.dart';
import 'package:gofit/NetworkHandler.dart';
import 'package:flutter/material.dart';
import '../screens/home/homepage_user.dart';

class MainProfile extends StatefulWidget {
  const MainProfile({super.key});

  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  Widget currentTab = const MenuView();
  int currentState = 0;
  List<String> titleString = ["Home Page", "Profile Page"];
  bool circular = true;

  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel(DOB: '_dob',
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
    var response = await networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
  }

  void updateProfile() async {
    // Construct the update data
    var updateData = {
      "name": profileModel.name,
      "profession": profileModel.profession,
      "DOB": profileModel.DOB,
      "titleline": profileModel.titleline,
      "about": profileModel.about,
    };

    // Send an HTTP request to update the profile
    var response = await networkHandler.patch("/profile/update", updateData);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData != null && responseData['data'] != null) {
        // Profile updated successfully
        // fetchData(); // Refresh the profile data
        // Navigator.of(context).pop(); //Close the edit dialog
      } else {
        // Handle the error, e.g., display an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to update profile. Please try again."),
          ),
        );
      }
    } else {
      // Handle the error, e.g., display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to update profile. Please try again."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //   iconTheme: const IconThemeData(
      //     color: Colors.grey, // Set the color of the Drawer icon to grey
      //   ),
      //   backgroundColor: Colors.white,
      //   // title: Text(titleString[currentState]),
      //   centerTitle: true,
      //   actions: <Widget>[
      //     IconButton(icon: const Icon(Icons.notifications,
      //       color: Colors.grey,),
      //         onPressed: () {}),
      //   ],
      // ),
      // backgroundColor: Colors.white,


      body: circular
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        children: <Widget>[
          IconButton(
            alignment: Alignment.centerRight,
            icon: const Icon(Icons.edit_note,
              color: Colors.black54,
              size: 40
              ,),
            onPressed: () {
              // Display the edit dialog
              _showEditDialog(context);
            },
            // color: Colors.deepOrange,
          ),
          head(),

          const SizedBox(height: 16),
          const Divider(
            thickness:1,
          ),
          const SizedBox(height: 16),
          otherDetails("Your Name ", profileModel.name),

          const Divider(
            thickness: 0.4,
          ),
          otherDetails("About You ", profileModel.about),
          const Divider(
            thickness: 0.4,
          ),
          otherDetails("Date of Birth ", profileModel.DOB),
          const Divider(
            thickness: 0.4,
          ),
          otherDetails("Education ", profileModel.profession),
          // Divider(
          //   thickness: 1,
          // ),
          const SizedBox(height: 159),
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              "Your Posts",
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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.,
        children: <Widget>[
          // SizedBox(
          //   height: 10,
          // ),
          Center(
            child: CircleAvatar(
              radius: 90,
              backgroundImage: NetworkHandler().getImage(
                  profileModel.username as String),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            profileModel.username as String,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500
                , color: Colors.black87),
          ),
          const SizedBox(
            height: 7,
          ),
          Center(
            child: Text(profileModel.titleline,
    style: const TextStyle(fontSize: 14,
        // fontWeight: FontWeight.w500,
        color: Colors.black87),
    ),
          ),
        ],
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical:4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label ",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.deepOrange,
                // color: Color.fromRGBO(
                // 255, 77, 0, 1.0),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 17,
              fontWeight: FontWeight.w400, color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: "Name"),
                  initialValue: profileModel.name,
                  onChanged: (value) {
                    setState(() {
                      profileModel.name = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Profession"),
                  initialValue: profileModel.profession,
                  onChanged: (value) {
                    setState(() {
                      profileModel.profession = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "DOB"),
                    initialValue: profileModel.DOB,
                    onChanged: (value) {
                      setState(() {
                        profileModel.DOB = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "About"),
                  initialValue: profileModel.about,
                  onChanged: (value) {
                    setState(() {
                      profileModel.about = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Save changes and close the dialog
                updateProfile(); // Update the profile
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: profileModel.DOB != null
          ? DateFormat("yyyy-MM-dd").parse(profileModel.DOB)
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null &&
        picked != DateFormat("yyyy-MM-dd").parse(profileModel.DOB)) {
      setState(() {
        profileModel.DOB = DateFormat("yyyy-MM-dd").format(picked);
      });
    }
  }


}

