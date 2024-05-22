import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gofit/screens/home/homepage_user.dart';
import 'package:gofit/screens/main_tab/mainTanloging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gofit/screens/login/signup_screen.dart';
// import '../../Admin/admin.dart';
import '../../Authenticate/Methods.dart';
import '../../Coach/MenuCoach.dart';
import '../../NetworkHandler.dart';
import '../../Nutritionist/Menu_Nutri.dart';
import 'homepage_user_web.dart';
// line 475
// import 'package:google_fonts/google_fonts.dart';

class LoginScreenweb extends StatefulWidget {
  // LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenweb> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController gmail = TextEditingController();
  String errorMessage = '';
  late String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();

  Future<void> loginUser(String username, String password) async {
    // تحقق من نوع المستخدم بناءً على الاسم المدخل
    String userType = "Default"; // النوع الافتراضي
    // if(username.startsWith("Admin") || username.startsWith("admin") ){
    //   //Login Logic start here
    //   Map<String, String> data = {
    //     "username": _usernameController.text,
    //     "password": passwordController.text,
    //   };
    //   var response = await networkHandler.post('/admin/login', data);
    //   if (response.statusCode == 200 ||
    //       response.statusCode == 201) {
    //     Map<String, dynamic> output = json.decode(response.body);
    //     print(output["token"]);
    //     await storage.write(key: "token", value: output["token"]);
    //     final token = output["token"];
    //     await saveToken(token);
    //     setState(() {
    //       validate = true;
    //       circular = false;
    //     });
    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(
    //
    //           builder: (context) => DrawerDemo(),
    //         ),
    //             (route) => false);
    //   } else {
    //     String output = json.decode(response.body);
    //     setState(() {
    //       validate = false;
    //       errorText = output;
    //       circular = false;
    //     });
    //   }
    // }else
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
              builder: (context) => MenuView2(),
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
            builder: (context) => MenuCoach(),
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
            builder: (context) => MenuNutrui(),
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
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          Menu(),

          Body(  usernameController: _usernameController,
            gmail: gmail,
            passwordController: passwordController,
            loginUser: loginUser,)

        ],

      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _menuItem(title: 'Home'),
              _menuItem(title: 'About us'),
              _menuItem(title: 'Contact us'),
              _menuItem(title: 'Help'),
            ],
          ),
          Row(
            children: [
              _menuItem(title: 'Sign In', isActive: true),
              _registerButton(context)
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuItem({String title = 'Title Menu', isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.deepOrange : Colors.grey,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            isActive
                ? Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(30),
              ),
            )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 3,
            blurRadius: 9,
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          // Navigate to NewAccountScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewAccountScreen()),
          );
        },
        child: Text(
          'Register',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );

  }
}

class Body extends StatelessWidget {
  late   bool isPasswordVisible = false;
  final TextEditingController usernameController;
  final TextEditingController gmail;
  final TextEditingController passwordController;
  final Function(String, String) loginUser;

  Body({
    required this.usernameController,
    required this.gmail,
    required this.passwordController,
    required this.loginUser,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In to \nGoFit Application',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "If you don't have an account",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "You can",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      print(MediaQuery.of(context).size.width);
                    },
                    child: Text(
                      "Register here!",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              // Image.asset(
              //   'assets/images/illustration-2.png',
              //   width: 300,
              // ),
            ],
          ),
        ),

        Image.asset(
          // 'img/GoFIT5.png',
          'images/illustration-1.png',
          width: 300,
        ),

        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: Container(
            width: 320,
            child: _formLogin(),
          ),
        )
      ],
    );
  }

  Widget _formLogin() {
    return Column(
      children: [
        TextField(
          controller: gmail,
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
          controller: usernameController,
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
        SizedBox(height: 30),
        TextField(
          controller: passwordController ,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                // setState(() {
                //   isPasswordVisible = !isPasswordVisible;
                // });
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
        SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.deepOrange,
                spreadRadius: 1,
                blurRadius: 9,
              ),
            ],
          ),
          child:

          GestureDetector(
            onTap: () async {
              try {
                await loginUser(
                  usernameController.text,
                  passwordController.text,
                );
               logIn(gmail.text,   passwordController.text);
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
        ),
        SizedBox(height: 40),
        Row(children: [
          Expanded(
            child: Divider(
              color: Colors.grey[300],
              height: 50,

            ),
          ),
          //
          // Expanded(
          //   child: Divider(
          //     color: Colors.grey[400],
          //     height: 50,
          //   ),
          // ),
        ]),

      ],
    );
  }

  Widget _loginWithButton({required String image, bool isActive = false}) {
    return Container(
      width: 90,
      height: 70,
      decoration: isActive
          ? BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 10,
            blurRadius: 30,
          )
        ],
        borderRadius: BorderRadius.circular(15),
      )
          : BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
          child: Container(
            decoration: isActive
                ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 15,
                )
              ],
            )
                : BoxDecoration(),
            child: Image.asset(
              '$image',
              width: 35,
            ),
          )),
    );
  }
}