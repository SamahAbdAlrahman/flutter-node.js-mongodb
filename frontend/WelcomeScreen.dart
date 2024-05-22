import 'package:flutter/material.dart';
import 'package:gofit/screens/login/login_screen.dart';
import 'package:gofit/screens/login/on_boarding_view.dart';
import 'package:gofit/screens/login/signup_screen.dart';
import 'package:gofit/screens/login/step1_view.dart';

// import 'loginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       height: double.infinity,
       width: double.infinity,
       decoration: const BoxDecoration(
         gradient: LinearGradient(
           colors: [
             Color(0xff000207),
             Color(0xffff7300),
             // 0xffe86c0e
           ]
         )
       ),
       child: Column(
         children: [
           const Padding(
             padding: EdgeInsets.only(top: 5),
             child: Image(image: AssetImage('assets/logo.png')),
           ),
           const SizedBox(
             height: 0,
           ),
           const Text('Welcome Back',style: TextStyle(
             fontSize: 30,
             color: Colors.white
           ),),
          const SizedBox(height: 15,),
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  LoginScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(child: Text('SIGN IN',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),),
            ),
          ),
           const SizedBox(height: 25,),
           GestureDetector(
             onTap: (){
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) =>  Step1View()));
             },
             child: Container(
               height: 53,
               width: 320,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(30),
                 border: Border.all(color: Colors.white),
               ),
               child: const Center(child: Text('SIGN UP',style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Colors.black
               ),),),
             ),
           ),
           const SizedBox(height: 25,),
           GestureDetector(
             onTap: (){
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) =>  OnBoardingView()));
             },
             child: Container(
               height: 53,
               width: 320,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(30),
                 border: Border.all(color: Colors.white),
               ),
               child: const Center(child: Text('Guest',style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Colors.white
               ),),),
             ),
           ),

           const Spacer(),
           const Image(image: AssetImage('assets/social2.png')),
           const SizedBox(height: 2,),
           const Text('Contact Us with Social Media',style: TextStyle(
               fontSize: 17,
               color: Colors.white70
           ),),//
          const SizedBox(height: 60,),

          ]
       ),
     ),

    );
  }
}
