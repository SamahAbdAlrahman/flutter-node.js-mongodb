//
// import "package:flutter/material.dart";
//
// import '../NetworkHandler.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// import '../screens/login/on_boarding_view.dart';
//
// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});
//
//   @override
//   _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
// }
//
// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   bool vis = true;
//   final _globalkey = GlobalKey<FormState>();
//   NetworkHandler networkHandler = NetworkHandler();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   late String errorText;
//   bool validate = false;
//   bool circular = false;
//   final storage = const FlutterSecureStorage();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         // height: MediaQuery.of(context).size.height,
//         // width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.white, Colors.green[200] ?? Colors.green],
//             begin: const FractionalOffset(0.0, 1.0),
//             end: const FractionalOffset(0.0, 1.0),
//             stops: const [0.0, 1.0],
//             tileMode: TileMode.repeated,
//           ),
//         ),
//         child: Form(
//           key: _globalkey,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Forgot Password",
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 2,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 usernameTextField(),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 passwordTextField(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     Map<String, String> data = {
//                       "password": _passwordController.text
//                     };
//                     print("/user/update/${_usernameController.text}");
//                     var response = await networkHandler.patch(
//                         "/user/update/${_usernameController.text}", data);
//
//                     if (response.statusCode == 200 ||
//                         response.statusCode == 201) {
//                       print("/user/update/${_usernameController.text}");
//                       Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const OnBoardingView()),
//                           (route) => false);
//                     }
//
//                     // login logic End here
//                   },
//                   child: Container(
//                     width: 150,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color:const Color.fromRGBO(248, 96, 2, 1.0),
//                     ),
//                     child: Center(
//                       child: circular
//                           ? const CircularProgressIndicator()
//                           : const Text(
//                               "Update Password",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//                 // Divider(
//                 //   height: 50,
//                 //   thickness: 1.5,
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget usernameTextField() {
//     return Column(
//       children: [
//         const Text("Username"),
//         TextFormField(
//           controller: _usernameController,
//           decoration: InputDecoration(
//             errorText: validate ? null : errorText,
//             focusedBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.black,
//                 width: 2,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
//
//   Widget passwordTextField() {
//     return Column(
//       children: [
//         const Text("Password"),
//         TextFormField(
//           controller: _passwordController,
//           obscureText: vis,
//           decoration: InputDecoration(
//             errorText: validate ? null : errorText,
//             suffixIcon: IconButton(
//               icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
//               onPressed: () {
//                 setState(() {
//                   vis = !vis;
//                 });
//               },
//             ),
//             helperStyle: const TextStyle(
//               fontSize: 14,
//             ),
//             focusedBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.black,
//                 width: 2,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
