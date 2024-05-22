import 'package:flutter/material.dart';
import 'package:gofit/Admin/new_coach.dart';
import '../chat/group_chats/group_chat_screen.dart';
import 'newNutritionist.dart';
//
// void main() => runApp(MaterialApp(
//   home: DrawerDemo(),
// ));

class DrawerDemo extends StatefulWidget {
  const DrawerDemo({super.key});

  @override
  _DrawerDemoState createState() => _DrawerDemoState();
}

class _DrawerDemoState extends State<DrawerDemo> {
  bool isDrawerOpen = false;

  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(248, 96, 2, 1.0),
                    Color.fromRGBO(190, 57, 33, 1.0)
                  ],
                ),
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/img/u1.png'),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.table_rows),
              title: const Text('Tables'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Gym information'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Statics'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(

              leading: const Icon(Icons.mark_unread_chat_alt),
              title: const Text("New Chat"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) =>  GroupChatHomeScreen()));
              },  ),



            // Add more ListTile widgets for additional menu items
            ListTile(
              leading: const Icon(Icons.add_circle_outline_sharp),
              title: const Text('Add Coach'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NewCoach()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline_sharp),
              title: const Text('Add Nutritionist'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const newNutritionist()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back_ios_new_sharp),
              title: const Text('Close'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.black,
                // expandedHeight: media.width * 0.25,
                collapsedHeight: kToolbarHeight + 20,
                flexibleSpace: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          colors: [
                            Color.fromRGBO(248, 96, 2, 1.0),
                            Color.fromRGBO(190, 57, 33, 1.0)
                          ],
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.all(40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Home page",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'LibreBaskerville',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}
