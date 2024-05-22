// import 'package:chat_appapp/group_chats/group_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'group_info.dart';

class GroupChatRoom extends StatelessWidget {
  final String groupChatId, groupName;

  GroupChatRoom({required this.groupName, required this.groupChatId, Key? key})
      : super(key: key);

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> chatData = {
        "sendBy": _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();

      await _firestore
          .collection('groups')
          .doc(groupChatId)
          .collection('chats')
          .add(chatData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false, // Hide the back arrow
        backgroundColor: Color.fromARGB(134, 234, 232, 252),
        title: Text(groupName),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => GroupInfo(
                        groupName: groupName,
                        groupId: groupChatId,
                      ),
                    ),
                  ),
              icon: Icon(Icons.more_vert) ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.27,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('groups')
                    .doc(groupChatId)
                    .collection('chats')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> chatMap =
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                        return messageTile(size, chatMap);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 19,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 3,
                      width: size.width / 1.29,
                      child: TextField(
                        controller: _message,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.photo),
                            ),
                            hintText: "Send Message",
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(8),
                            // )
                          focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                        color: Colors.deepOrange, //
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send), onPressed: onSendMessage),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  // Widget messageTile(Size size, Map<String, dynamic> chatMap) {
  //   return Builder(builder: (_) {
  //     if (chatMap['type'] == "text") {
  //       return Container(
  //         width: size.width,
  //         alignment: chatMap['sendBy'] == _auth.currentUser!.displayName
  //             ? Alignment.centerRight
  //             : Alignment.centerLeft,
  //         child: Container(
  //             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
  //             margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(15),
  //               color: Colors.blue,
  //             ),
  //             child: Column(
  //               children: [
  //                 Text(
  //                   chatMap['sendBy'],
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.w500,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: size.height / 200,
  //                 ),
  //                 Text(
  //                   chatMap['message'],
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w500,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ],
  //             )),
  //       );
  //     } else if (chatMap['type'] == "img") {
  //       return Container(
  //         width: size.width,
  //         alignment: chatMap['sendBy'] == _auth.currentUser!.displayName
  //             ? Alignment.centerRight
  //             : Alignment.centerLeft,
  //         child: Container(
  //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
  //           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
  //           height: size.height / 2,
  //           child: Image.network(
  //             chatMap['message'],
  //           ),
  //         ),
  //       );
  //     } else if (chatMap['type'] == "notify") {
  //       return Container(
  //         width: size.width,
  //         alignment: Alignment.center,
  //         child: Container(
  //           padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
  //           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(5),
  //             color: Colors.black38,
  //           ),
  //           child: Text(
  //             chatMap['message'],
  //             style: TextStyle(
  //               fontSize: 14,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //       );
  //     } else {
  //       return SizedBox();
  //     }
  //   }
  //
  //   );
  // }
  Widget messageTile(Size size, Map<String, dynamic> chatMap) {
    return Builder(builder: (_) {
      if (chatMap['type'] == "text") {
        bool sentByCurrentUser =
            chatMap['sendBy'] == _auth.currentUser!.displayName;

        return Container(
          width: size.width,
          alignment: sentByCurrentUser
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: sentByCurrentUser ? Colors.blueGrey
                  : Colors.deepOrangeAccent,
            ),
            child: Column(
              children: [
                Text(
                  chatMap['sendBy'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: size.height / 200,
                ),
                Text(
                  chatMap['message'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (chatMap['type'] == "img") {
        return Container(
          width: size.width,
          alignment: chatMap['sendBy'] == _auth.currentUser!.displayName
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            height: size.height / 2,
            child: Image.network(
              chatMap['message'],
            ),
          ),
        );
      } else if (chatMap['type'] == "notify") {
        return Container(
          width: size.width,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black38,
            ),
            child: Text(
              chatMap['message'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else {
        return SizedBox();
      }
    });
  }

}
