// import 'package:flutter/material.dart';
// import 'package:gofit/common/app_colors.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_svg/svg.dart';
//
//
// import '../../Blog/addBlog.dart';
// import '../../NetworkHandler.dart';
// import '../../Nutritionist/Menu_Nutri.dart';
// import '../../Profile/ProfileScreen.dart';
// import '../../Screen/posts_view.dart';
//
// import '../../WelcomeScreen.dart';
// import '../../chat/group_chats/group_chat_screen.dart';
// import '../../screens/User/search.dart';
// import '../../screens/home/homepage_user.dart';
//
//
// class SideBar2 extends StatefulWidget {
//   @override
//   _SideBarState createState() => _SideBarState();
// }
//
// class _SideBarState extends State<SideBar2> {
//   @override
//   void logout() async {
//     await storage.delete(key: "token");
//     Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => const WelcomeScreen()),
//             (route) => false);
//   }
//   int currentState = 0;
//   List<Widget> widgets = [ MenuView(), const ProfileScreen()];
//   // List<String> titleString = ["Home Page", "Profile Page"];
//   final storage = const FlutterSecureStorage();
//   NetworkHandler networkHandler = NetworkHandler();
//   String username = "";
//   Widget profilePhoto = Container(
//     height: 100,
//     width: 100,
//     decoration: BoxDecoration(
//       color: Colors.deepOrange,
//       borderRadius: BorderRadius.circular(50),
//     ),
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
//     // super.initState();
//     checkProfile();
//   }
//
//   void checkProfile() async {
//     var response = await networkHandler.get("/profile/checkProfile");
//     setState(() {
//       username = response['username'];
//     });
//     if (response["status"] == true) {
//       setState(() {
//         profilePhoto = CircleAvatar(
//           radius: 50,
//           backgroundImage: NetworkHandler().getImage(response['username']),
//         );
//       });
//     } else {
//       setState(() {
//         profilePhoto = Container(
//           height: 100,
//           width: 100,
//           decoration: BoxDecoration(
//             color: Colors.grey,
//             borderRadius: BorderRadius.circular(50),
//           ),
//         );
//       });
//     }
//   }
//   ///
//
//   Widget build(BuildContext context) {
//     return Drawer(
//
//       elevation: 0,
//       child: Container(
//         // width: 50,
//         // white70
//         // color: Color(0xFFE9E9E9),
//         // color: AppColor.bgSideMenu,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Container(
//               // width: 100,
//
//               margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               child: Text(
//                "     Welcome\n     Guest" ,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.deepOrangeAccent,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//               ),
//               child: Container(
//                 alignment: Alignment.center,
//                 // child: Image.asset(
//                 //   "assets/img/GoFIT6-removebg-preview.png",
//                 //   width: 50, // Adjust the width as needed
//                 //   height: 50, // Adjust the height as needed
//                 //   fit: BoxFit.cover,
//                 // ),
//                 child:const Text('Log in to enjoy\nall our services',style: TextStyle(color: Colors.white70 ,
//                 fontSize: 15),)
//               ),
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.person,   color: Colors.white, size: 16,), // لون الأيقونة
//               title: Text(
//                 "Create Account",
//                 style: TextStyle(
//                   color: Colors.white, // لون النص
//                 ),
//               ),
//
//             ),
//             ListTile(
//               leading: const Icon(Icons.login_sharp,   color:Colors.white, size: 16,), // لون الأيقونة
//               title: Text(
//                 "Login",
//                 style: TextStyle(
//                   color: Colors.white, // لون النص
//                 ),
//               ),
//
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings,   color: Colors.white, size: 16,), // لون الأيقونة
//               title: Text(
//                 "Settings",
//                 style: TextStyle(
//                   color: Colors.white, // لون النص
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.feedback,   color: Colors.white, size: 16,), // لون الأيقونة
//               title: Text(
//                 "Feedback",
//                 style: TextStyle(
//                   color:Colors.white,// لون النص
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout_rounded,   color:Colors.white, size: 16,), // لون الأيقونة
//               title: Text(
//                 "Logout",
//                 style: TextStyle(
//                   color: Colors.white, // لون النص
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DrawerListTile extends StatelessWidget {
//   final String title, icon;
//   final VoidCallback press;
//
//   const DrawerListTile({ Key? key, required this.title, required this.icon, required this.press})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: press,
//       horizontalTitleGap: 0.0,
//       leading: Image.asset(
//         icon,
//         color: AppColor.white,
//         height: 16,
//       ),
//       title: Text(
//         title,
//         style: TextStyle(color: AppColor.white),
//       ),
//     );
//   }
// }
