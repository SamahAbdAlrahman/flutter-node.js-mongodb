import 'package:gofit/common/colo_extension.dart';
import 'package:gofit/common_widget/tab_button1.dart';
import 'package:flutter/material.dart';

import '../../Pages/widget/side_bar_menu.dart';
import '../../Profile/ProfileScreen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../NetworkHandler.dart';
import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../../common/colo_extension.dart';
import '../../common_widget/tab_button.dart';
import 'create_chat/new_chat.dart';
import 'group_chat_room.dart';
import '../../Profile/viewProfile.dart'; // Import 'File' from dart:io with a prefix
import '../../NetworkHandler.dart';
class chatweb extends StatefulWidget {
  const chatweb({Key? key}) : super(key: key);

  @override
  _GroupChatHomeScreenState createState() => _GroupChatHomeScreenState();
}

class _GroupChatHomeScreenState extends State<chatweb> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  List groupList = [];

  String? groupName;
  String? groupId;

  @override
  void initState() {
    super.initState();
    getAvailableGroups();
  }

  void getAvailableGroups() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide the back arrow
        // backgroundColor: Color.fromARGB(255, 190, 89, 35),
        backgroundColor:AppColor.bgSideMenu,
        // backgroundColor: Color.fromARGB(255, 243, 92, 10),
        // backgroundColor:Color(0xFFE9E9E9),
        title: Text(
          "Chats",
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontWeight: FontWeight.bold// Set your desired text color
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body:

      isLoading
          ?

      Container(
        color: Colors.white,
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),

      )
          :

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search field
          if (AppResponsive.isDesktop(context))
    // Expanded(
    //
    //   child: SideBar(),
    // ),
            Container(
      // constraints: BoxConstraints(
        width: 222,

      child: SideBar(),
    ),


    /// Main Body Part


          // Right side (Chat room)
          Expanded(

            // child:AppColor.bgSideMenu,

            child: groupName != null && groupId != null
                ? GroupChatRoom(
              groupName: groupName!,
              groupChatId: groupId!,
            )
                : Container(),
          ),
          Container(
            color: Colors.white,
            width: size.width * 0.25,
            child: Column(

              children: [
                // Search bar
                Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search or start new chat ...',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.deepOrangeAccent, // Set your desired border color
                          width: 2.0, // Set your desired border width
                        ),
                      ),
                    ),
                    // Add your search logic here
                    onChanged: (value) {
                      // Update the UI based on the search value
                      // You may want to filter the groupList based on the search value
                    },
                  ),
                )
                ,
                // List of groups
                Expanded(
                  child: ListView.builder(
                    itemCount: groupList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Divider(
                            height: 8,
                            color: Colors.white70,
                          ),
                          ListTile(
                            onTap: () {
                              // Set the selected group information
                              groupName = groupList[index]['name'];
                              groupId = groupList[index]['id'];

                              // Rebuild the widget to show the selected chat on the right
                              setState(() {});
                            },
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage('assets/g2.png'),
                            ),
                            title: Text(
                              groupList[index]['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Divider(
                            height: 8,
                            color: Colors.blueGrey.shade50,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      )
,
        floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddMembersInGroup(),
          ),
        ),
        tooltip: "New Chat",
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 204, 120, 75),
                Color.fromARGB(255, 190, 89, 35),
                Color.fromARGB(245, 190, 35, 71),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.add_comment, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white70,
      // backgroundColor:AppColor.bgSideMenu,

    );

  }
}