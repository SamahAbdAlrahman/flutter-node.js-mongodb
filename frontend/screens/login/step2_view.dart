import 'package:flutter/material.dart';
import 'package:gofit/screens/login/signup_screen.dart';

// import '../../common/colo_extension.dart';
 import '../../common/colo_extension.dart';
import '../../common_widget/fitness_level_selector.dart';
import '../../common_widget/round_button.dart';

class Step2View extends StatefulWidget {
  const Step2View({super.key});

  @override
  State<Step2View> createState() => _Step2ViewState();
}

class _Step2ViewState extends State<Step2View> {
  var selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: TColor.white,
          centerTitle: true,
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Image.asset(
          //       "assets/img/back.png",
          //       width: 25,
          //       height: 25,
          //     )
          // ),
          title: Text(
            "Step 2 of 3",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Select your fitness level",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 25,),
              FitnessLevelSelector(
                title: "Beginer",
                subtitle: "You are new to fitness training",
                isSelect: selectIndex == 0,
                onPressed: () {
                  setState(() {
                    selectIndex = 0;
                  });
                },
              ),
              FitnessLevelSelector(
                title: "Intermediate",
                subtitle: "You have been training regularly",
                isSelect: selectIndex == 1,
                onPressed: () {
                  setState(() {
                    selectIndex = 1;
                  });
                },
              ),

              FitnessLevelSelector(
                title: "Advanced",
                subtitle: "You're fit and ready for an intensive workout plan",
                isSelect: selectIndex == 2,
                onPressed: () {
                  setState(() {
                    selectIndex = 2;
                  });
                },
              ),
              
              
              const Spacer(),

              GestureDetector(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  NewAccountScreen() ));
                },
                child: Container(
                  height: 55,
                  width: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: const LinearGradient(
                      colors: [
                        // Color(0xff000207),
                        Color(0xff000207),
                        // Color(0xffff7300),
                        Color(0xffff6200),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18,)
,              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [1, 2, 3].map((pObj) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        color: 2 == pObj
                            ? TColor.primaryColor2
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(6)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 25,)
            ],
          ),
        ));
  }
}
