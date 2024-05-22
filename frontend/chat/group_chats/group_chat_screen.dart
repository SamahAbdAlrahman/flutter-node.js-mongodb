import 'package:gofit/common/colo_extension.dart';
import 'package:gofit/common_widget/tab_button1.dart';
import 'package:flutter/material.dart';

import '../../Profile/ProfileScreen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../NetworkHandler.dart';
import '../../common/colo_extension.dart';
import '../../common_widget/tab_button.dart';
import 'create_group/add_members.dart';
import 'group_chat_room.dart';
import '../../Profile/viewProfile.dart'; // Import 'File' from dart:io with a prefix
import '../../NetworkHandler.dart';
class GroupChatHomeScreen extends StatefulWidget {
  const GroupChatHomeScreen({Key? key}) : super(key: key);

  @override
  _GroupChatHomeScreenState createState() => _GroupChatHomeScreenState();
}

class _GroupChatHomeScreenState extends State<GroupChatHomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  List groupList = [];

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
        backgroundColor: Colors.deepOrangeAccent,
        // backgroundColor: Color.fromARGB(255, 243, 92, 10),
        title: Text(
          "Chats",
          style: TextStyle(
            color: Colors.white, // Set your desired text color
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body:
      isLoading
          ?

      Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),

      )
          :
      ListView.builder(
        itemCount: groupList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Divider(
                height:8,
                color: Colors.white70,
              ),
              ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GroupChatRoom(
                      groupName: groupList[index]['name'],
                      groupChatId: groupList[index]['id'],
                    ),
                  ),
                ),
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
                height:8,
                color: Colors.blueGrey.shade50
              ),
            ],
          );
        },
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
                // Colors.deepOrangeAccent,
                // Colors.black
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
            child: Icon(Icons.add_comment, color:
            Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,

      //






      //
    );
  }
}
