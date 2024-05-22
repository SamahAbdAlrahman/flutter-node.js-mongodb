import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gofit/Authenticate/Methods.dart';
import 'package:flutter/material.dart';

import '../../common/colo_extension.dart';
import '../../configs.dart';
import 'login_screen.dart';
class NewAccountScreen extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<NewAccountScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: isLoading
            ? Center(
          child: Container(
            height: size.height / 20,
            width: size.height / 20,

            child: CircularProgressIndicator(),
          ),
        )
            : Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff000207),
                  Color(0xffff6200),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 45.0, left: 22),
                child: Text(
                  'Create Your\nAccount',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 185.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child:  Padding(
                  padding: const EdgeInsets.only(left: 32.0,right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      TextField(
                        controller: _name,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Full Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffff4a05),
                            ),
                          ),
                        ),

                      ),

                      TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Gmail',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffff4a05),
                            ),
                          ),
                        ),
                      ),

                      TextField(
                        controller: _password,
                        obscureText: !isPasswordVisible, // Toggle the visibility of the password
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });

                              // Check password length and show error message if needed
                              if (_password.text.length < 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Password must be at least 6 characters'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: Icon(
                              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          label: Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // color:  TColor.primaryColor2,
                              color: Color(0xffff4a05),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40,),
                      customButton(),

                      const SizedBox(height:63,),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Don't have account?",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),),

                            Text("Sign in",style: TextStyle(///done login page
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black
                            ),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
  Widget customButton() {
    return GestureDetector(
      onTap: () async {
        if (_name.text.isNotEmpty && _email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          var regBody = {
            "email": _email.text,
            "password": _password.text,
            "username": _name.text,
          };

          final Uri apiUrl = Uri.parse(register);
          var response = await http.post(
            apiUrl,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody),
          );

          // Check the status code of the response
          if (response.statusCode == 200 || response.statusCode == 201) {
            // Registration successful
            createAccount(_name.text, _email.text, _password.text).then((user) {
              if (user != null) {
                setState(() {
                  isLoading = false;
                });
                Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                print("Account Created Successfully");
              } else {
                print("Login Failed");
                setState(() {
                  isLoading = false;
                });
              }
            }

            );
          } else if (response.statusCode == 500|| response.statusCode == 409 ) {
            // Email or name already exists, show a snackbar with the error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Email or name already exists'),
                duration: Duration(seconds: 2),
              ),
            );
            setState(() {
              isLoading = false;
            });
          } else {
            // Handle other status codes or errors
            print("Error during registration: ${response.statusCode}");
            setState(() {
              isLoading = false;
            });
          }
        } else {
          print("Please enter Fields");
        }
      },
      child: Container(
        height: 50,
        width: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color(0xff000207),
              // Color(0xffff7300),
              Color(0xffff6200),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'SIGN UP',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

//
// Widget customButton() {
//   return GestureDetector(
//     onTap: () async {
//       if (_name.text.isNotEmpty &&
//           _email.text.isNotEmpty &&
//           _password.text.isNotEmpty) {
//         setState(() {
//           isLoading = true;
//         });
//         var regBody = {
//           "email": _email.text,
//           "password": _password.text,
//           "username": _name.text,
//         };
//         final Uri apiUrl = Uri.parse(register);
//         var response = await http.post(
//           apiUrl,
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode(regBody),
//         );
//         createAccount(_name.text, _email.text, _password.text).then((user) {
//           if (user != null) {
//             setState(() {
//               isLoading = false;
//             });
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (_) => chatingScreen()));
//             print("Account Created Sucessfull");
//           } else {
//             print("Login Failed");
//             setState(() {
//               isLoading = false;
//             });
//           }
//         });
//       } else {
//         print("Please enter Fields");
//       }
//     },
//     child:     Container(
//       height: 50,
//       width: 280,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         gradient: const LinearGradient(
//             colors: [
//               Color(0xffff7300),
//               Color(0xff000207),
//             ]
//         ),
//       ),
//       child: const Center(child: Text('SIGN UP',style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 20,
//           color: Colors.white
//       ),),),
//     ),
//   );
// }

}
