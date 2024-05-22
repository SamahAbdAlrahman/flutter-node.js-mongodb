import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../group_chat_screen.dart';

class AddMembersInGroup extends StatefulWidget {
  const AddMembersInGroup({Key? key}) : super(key: key);

  @override
  State<AddMembersInGroup> createState() => _AddMembersInGroupState();
}

class _AddMembersInGroupState extends State<AddMembersInGroup> {
  final TextEditingController _search = TextEditingController();
  final TextEditingController _groupName = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> membersList = [];
  bool isLoading = false;
  Map<String, dynamic>? userMap;
  bool showCreateGroupForm = false;

  @override
  void initState() {
    super.initState();
    getCurrentUserDetails();
  }

  void getCurrentUserDetails() async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).get().then((map) {
      setState(() {
        membersList.add({
          "name": map['name'],
          "email": map['email'],
          "uid": map['uid'],
          "isAdmin": true,
        });
      });
    });
  }

  void _showChatNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Chat Name'),
          content: SingleChildScrollView(
            child: TextFormField(
              controller: _groupName,
              decoration: InputDecoration(
                hintText: 'Chat Name',
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: createGroup,
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });

    await _firestore.collection('users').where("name", isEqualTo: _search.text).get().then((value) {
      setState(() {
        if (value.docs.isNotEmpty) {
          userMap = value.docs[0].data();
        } else {
          // Handle the case when no user is found with the given name.
          userMap = null;
          showNoResultsSnackBar(); // Display a message when no results are found
        }
        isLoading = false;
      });

      if (userMap != null) {
        print(userMap);
      } else {
        print("User not found");
      }
    });
  }

  void showNoResultsSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No user found with the given name'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void onResultTap() {
    bool isAlreadyExist = false;

    for (int i = 0; i < membersList.length; i++) {
      if (membersList[i]['uid'] == userMap!['uid']) {
        isAlreadyExist = true;
      }
    }

    if (!isAlreadyExist) {
      setState(() {
        membersList.add({
          "name": userMap!['name'],
          "email": userMap!['email'],
          "uid": userMap!['uid'],
          "isAdmin": false,
        });

        userMap = null;
      });
    }
  }

  void onRemoveMembers(int index) {
    if (membersList[index]['uid'] != _auth.currentUser!.uid) {
      setState(() {
        membersList.removeAt(index);
      });
    }
  }

  void createGroup() async {
    setState(() {
      isLoading = true;
    });

    // Validate if the chat name is not empty
    if (_groupName.text.trim().isEmpty) {
      // Show an error message or handle the case where the chat name is empty
      return;
    }

    String groupId = Uuid().v1();

    await _firestore.collection('groups').doc(groupId).set({
      "members": membersList,
      "id": groupId,
    });

    for (int i = 0; i < membersList.length; i++) {
      String uid = membersList[i]['uid'];

      await _firestore.collection('users').doc(uid).collection('groups').doc(groupId).set({
        "name": _groupName.text,
        "id": groupId,
      });
    }

    await _firestore.collection('groups').doc(groupId).collection('chats').add({
      "message": "${_auth.currentUser!.displayName} Created This Group.",
      "type": "notify",
    });

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context); // Close the dialog

    // Optionally, you can also navigate or perform other actions here.
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white54,
        title: Text("Create New Chat"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: size.height /45),

                Flexible(
                  child: ListView.builder(
                    itemCount: membersList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => onRemoveMembers(index),
                        leading: Icon(Icons.account_circle_outlined),
                        title: Text(membersList[index]['name']),
                        subtitle: Text(membersList[index]['email']),
                        trailing: Icon(Icons.close),
                      );
                    },
                  ),
                ),
                SizedBox(height: size.height / 199),

                Container(
                  height: size.height / 14,
                  width: size.width/1.15,
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height / 14,
                    width: size.width / 1.15,
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height / 50),
                isLoading
                    ? Container(
                  height: size.height / 12,
                  width: size.height / 12,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
                    : GestureDetector(
                  onTap: onSearch,
                  child: Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: <Color>[
                          // Color(0xff000207),
                          // Color(0xffff7300),
                          Color.fromARGB(255, 204, 120, 75),
                          Color(0xffff7300),
                          Color.fromARGB(255, 255, 74, 5),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 18.9,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                userMap != null
                    ? ListTile(
                  onTap: onResultTap,
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text(userMap!['name']),
                  subtitle: Text(userMap!['email']),
                  trailing: Icon(Icons.add),
                )
                    : SizedBox(),
              ],
            ),
          ),
          if (showCreateGroupForm)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
                child: CreateGroup(
                  membersList: membersList,
                  onGroupCreated: () {
                    setState(() {
                      showCreateGroupForm = false;
                    });
                  },
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: membersList.length >= 2
          ? GestureDetector(
        onTap: () {
          // Show the dialog directly
          _showChatNameDialog();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // Colors.deepOrangeAccent, Colors.black
                Color.fromARGB(255, 204, 120, 75),

                Color.fromARGB(255, 190, 89, 35),
                Color.fromARGB(245, 190, 35, 71),
              ]
              ,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.forward, color: Colors.white),
          ),
        ),
      )
          : SizedBox(),
      backgroundColor: Colors.white,
    );
  }
}

class CreateGroup extends StatefulWidget {
  final List<Map<String, dynamic>> membersList;
  final VoidCallback onGroupCreated;

  const CreateGroup({required this.membersList, required this.onGroupCreated, Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final TextEditingController _groupName = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Enter Chat Name'),
                    backgroundColor: Colors.grey, // سكني فاتح
                    content: SingleChildScrollView(
                      child: TextFormField(
                        controller: _groupName,
                        decoration: InputDecoration(
                          hintText: 'Chat Name',
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('Cancel', style: TextStyle(color: Colors.deepOrange)),
                      ),
                      TextButton(
                        onPressed: createGroup,
                        child: Text('Create' ,style: TextStyle(color: Colors.deepOrange)),
                      ),
                    ],
                  );
                },
              );
            },

          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  void createGroup() async {
    setState(() {
      isLoading = true;
    });

    // Validate if the chat name is not empty
    if (_groupName.text.trim().isEmpty) {

      return;
    }

    String groupId = Uuid().v1();

    await _firestore.collection('groups').doc(groupId).set({
      "members": widget.membersList,
      "id": groupId,
    });

    for (int i = 0; i < widget.membersList.length; i++) {
      String uid = widget.membersList[i]['uid'];

      await _firestore.collection('users').doc(uid).collection('groups').doc(groupId).set({
        "name": _groupName.text,
        "id": groupId,
      });
    }

    await _firestore.collection('groups').doc(groupId).collection('chats').add({
      "message": "${_auth.currentUser!.displayName} Created This Group.",
      "type": "notify",
    });

    setState(() {
      isLoading = false;
    });

    widget.onGroupCreated();

    // Navigator.pop(context); // Close the dialog

    // Navigate to GroupChatHomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GroupChatHomeScreen(), // Replace with the actual name of your screen
      ),
    );
  }
}

