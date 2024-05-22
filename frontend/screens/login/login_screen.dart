import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gofit/screens/login/signup_screen.dart';
import '../../Admin/admin.dart';
import '../../Authenticate/Methods.dart';
import '../../Coach/MainTabView3.dart';
import '../../NetworkHandler.dart';
import '../../Nutritionist/MainTabView4.dart';
import '../main_tab/mainTanloging.dart';

class LoginScreen extends StatefulWidget {
  // LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController email = TextEditingController();
  String errorMessage = '';
  late String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  bool isPasswordVisible = false;

  Future<void> loginUser(String username, String password) async {
    // تحقق من نوع المستخدم بناءً على الاسم المدخل
    String userType = "Default"; // النوع الافتراضي
    if(username.startsWith("Admin") || username.startsWith("admin") ){
      //Login Logic start here
      Map<String, String> data = {
        "username": _usernameController.text,
        "password": passwordController.text,
      };
      var response = await networkHandler.post('/admin/login', data);
      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        Map<String, dynamic> output = json.decode(response.body);
        print(output["token"]);
        await storage.write(key: "token", value: output["token"]);
        final token = output["token"];
        await saveToken(token);
        setState(() {
          validate = true;
          circular = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(

              builder: (context) => DrawerDemo(),
            ),
                (route) => false);
      } else {
        String output = json.decode(response.body);
        setState(() {
          validate = false;
          errorText = output;
          circular = false;
        });
      }
    }else
    if (RegExp(r'^[a-zA-Z]+$').hasMatch(username)) {
      //Login Logic start here
      Map<String, String> data = {
        "username": _usernameController.text,
        "password": passwordController.text,
      };
      var response = await networkHandler.post('/user/login', data);
      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        Map<String, dynamic> output = json.decode(response.body);
        print(output["token"]);
        await storage.write(key: "token", value: output["token"]);
        setState(() {
          validate = true;
          circular = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              // builder: (context) => MenuView(),
              builder: (context) => MainTabView2(),
            ),
                (route) => false);
      } else {
        String output = json.decode(response.body);
        setState(() {
          validate = false;
          errorText = output;
          circular = false;
        });
      }
    }
    else if (RegExp(r'^119\d+').hasMatch(username)) {
      // إذا بدأ الاسم بـ 119 ويحتوي على أرقام
      userType = "Coach";
      Map<String, String> data = {
        "username": username,
        "password": password,
        "employeeType": userType, // ارسل نوع المستخدم مع البيانات
      };

      var response = await networkHandler.post('/employee/login', data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> output = json.decode(response.body);
        print(output["token"]);
        await storage.write(key: "token", value: output["token"]);
        setState(() {
          validate = true;
          circular = false;
        });

        // اختبار نوع المستخدم وتوجيهه إلى الصفحة المناسبة
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => maintabCoach(),
          ),
              (route) => false,
        );
      }
      else {
        String output = json.decode(response.body);
        setState(() {
          validate = false;
          errorText = output;
          circular = false;
        });
      }
    }
    else if (RegExp(r'^120\d+').hasMatch(username)) {
      // إذا بدأ الاسم بـ 120 ويحتوي على أرقام
      userType = "Nutritionist";

      Map<String, String> data = {
        "username": username,
        "password": password,
        "employeeType": userType, // ارسل نوع المستخدم مع البيانات
      };

      var response = await networkHandler.post('/employee/login', data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> output = json.decode(response.body);
        print(output["token"]);
        await storage.write(key: "token", value: output["token"]);
        setState(() {
          validate = true;
          circular = false;
        });

        // اختبار نوع المستخدم وتوجيهه إلى الصفحة المناسبة

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => maintabNutritionist(),
          ),
              (route) => false,
        );
      }
      else {
        String output = json.decode(response.body);
        setState(() {
          validate = false;
          errorText = output;
          circular = false;
        });
      }
    }
  }


  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff000207),
            Color(0xffff6200),
          ]),
        ),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     colors: [
        //       Color(0xffff7300),
        //       Color(0xff000207),
        //     ],
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SizedBox(height: 5),
            Padding(
              // padding: EdgeInsets.only(top:0, left: 22),
              padding: EdgeInsets.only(top:55.0, left: 22),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height:20),
            Expanded(
              key: _globalkey,
              // EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child:  Padding(
                  padding: const EdgeInsets.only(left:32,right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: email,
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
                        controller: _usernameController,
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
                        controller: passwordController,
                        obscureText: !isPasswordVisible, // Toggle the visibility of the password
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
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
                              color: Color(0xffff4a05),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password?',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xff170a01),
                        ),),
                      ),
                      const SizedBox(height:55,),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await loginUser(
                              _usernameController.text,
                              passwordController.text,
                            );
                             logIn(email.text,   passwordController.text);
                          } catch (e) {
                            print("Login failed: $e");
                          }
                        },
                        child: Container(
                          height: 55,
                          width: 300,
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
                              'SIGN IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 112,),
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
                            Text("Sign up",style: TextStyle(///done login page
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
        ),
      ),
    );

  }


}