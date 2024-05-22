import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../configs.dart';

class NewCoach extends StatefulWidget {
  const NewCoach({super.key});

  @override
  _NewCoachState createState() => _NewCoachState();
}

class _NewCoachState extends State<NewCoach> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool isLoading = false;
  bool _isNotValidate = false;
  bool isPasswordVisible = false;

  void registerUser() async {
    if (       passwordController.text.isNotEmpty &&
        usernameController.text.isNotEmpty) {
      var regBody = {
        "username": usernameController.text,
        "password": passwordController.text,
        "employeeType":"Coach",
        "email":emailController.text,
      };
      final Uri apiUrl = Uri.parse(registeremployee);
      var response = await http.post(
        apiUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(""),
              content: const Text("Create account successfully", style: TextStyle(color: Colors.black54),),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
                  },
                ),
              ],
            );
          },
        );
      } else {
        print("Something Went Wrong. Status code: ${response.statusCode}");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }



  Future<User?> createAccount(String name, String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      UserCredential userCrendetial = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print("Account created Succesfull");

      userCrendetial.user!.updateDisplayName(name);

      await firestore.collection('users').doc(auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "status": "Unavalible",
        "uid": auth.currentUser!.uid,
      });

      return userCrendetial.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
        child: SizedBox(
          height: size.height / 20,
          width: size.height / 20,
          child: const CircularProgressIndicator(),
        ),
      )
          :   Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // begin: Alignment.topCenter,
            colors: [
              Color(0xff000207),
              Color(0xffff6200),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 17),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(

                    "  Create Coach\n   Account",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(35),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 89),
                        Container(
                          // decoration: BoxDecoration(
                          //   color: Colors.white,
                          //   borderRadius: BorderRadius.circular(10),
                          //   boxShadow: const [
                          //     BoxShadow(
                          //       color: Color.fromRGBO(80, 78, 78, 1.0),
                          //       blurRadius: 30,
                          //       offset: Offset(0, 20),
                          //     ),
                          //   ],
                          // ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.check, color: Colors.grey),
                                  label: Text(
                                    'Coach Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffff4a05),
                                    ),
                                  ),
                                ),

                              ),

                              TextField(
                                controller: emailController,
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
                                controller: passwordController,
                                obscureText: !isPasswordVisible, // Toggle the visibility of the password
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });

                                      // Check password length and show error message if needed
                                      if (passwordController.text.length < 6) {
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


                            ],
                          ),
                        ),
                        const SizedBox(height: 60),
                        GestureDetector(
                          onTap: () {
                            if (usernameController.text.isNotEmpty &&
                                emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });

                              createAccount(usernameController.text, emailController.text, passwordController.text).then((user) {
                                if (user != null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  print("Account Created Sucessfull");
                                } else {
                                  print("Login Failed");
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              });
                            } else {
                              print("Please enter Fields");
                            }
                            registerUser();
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
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
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

