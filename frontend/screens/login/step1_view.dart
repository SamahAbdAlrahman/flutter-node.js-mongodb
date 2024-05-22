
import 'package:flutter/material.dart';
import 'package:gofit/screens/login/step2_view.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';

class Step1View extends StatefulWidget {
  const Step1View({super.key});

  @override
  State<Step1View> createState() => _Step1ViewState();
}

class _Step1ViewState extends State<Step1View> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true, title:   Text(
            "Step 1 of 3",
            style: TextStyle(
                // color:  TColor.primaryColor2,
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ), ),
      body: 
        
        SafeArea(
          child: Column(
            children: [
             

              const Spacer(),
              Image.asset(
                "assets/img/GoFIT7.png",
                width: media.width * 0.76,
                height: media.width * 0.76,
                fit: BoxFit.contain,
              ),


          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 27),
          //   child: Text(
          //     "Welcome to GoFit",
          //     textAlign:  TextAlign.center,
          //     style: TextStyle(
          //         color: Colors.black87,
          //         fontSize: 24,
          //         fontWeight: FontWeight.w700),
          //   ),
          // ),

           Text(          'Now enjoy all our services at any \n time and from anywhere ',
            // "Personalized workouts will help you\ngain strength, get in better shape and\nembrace a healthy lifestyle",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w400),
          ),
              const Spacer(),
              
               GestureDetector(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Step2View() ));
                },
                child: Container(
                  height: 55,
                  width: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: const LinearGradient(
                      colors: [
                        // Color(0xff000207),
                        // Color(0xffff7300),
                        Color(0xff000207),
                        // Color(0xffff7300),
                        Color(0xffff6200),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [1, 2, 3].map((pObj) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        color: 1 == pObj ?
                        TColor.primaryColor2 :
                        TColor.gray.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(6)),
                  );
                }).toList(),
              ),


             const SizedBox(height: 25,)
            ],
          ),
        )

    );
  }
}