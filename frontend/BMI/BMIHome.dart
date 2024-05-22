import 'dart:math';

import 'package:gofit/BMI/age_weight_widget.dart';
import 'package:gofit/BMI/gender_widget.dart';
import 'package:gofit/BMI/height_widget.dart';
import 'package:gofit/BMI/score_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class BMI extends StatefulWidget {
  const BMI({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<BMI> {
  int _gender = 0;
  int _height = 150;
  int _age = 30;
  int _weight = 50;
  bool _isFinished = false;
  double _bmiScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  leading: IconButton(
    icon: Icon(
      Icons.arrow_back_outlined,
      color: Colors.white,
    ),
    onPressed: () {
      Navigator.pop(context);

    },
  ),
  backgroundColor: Colors.deepOrange,
  title: Text("BMI Calculater",style: TextStyle(color: Colors.white),),
  centerTitle: true,

),
      body: SingleChildScrollView(
padding: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                //Lets create widget for gender selection
                GenderWidget(

                  onChange: (genderVal) {
                    _gender = genderVal;
                  },
                ),
                SizedBox(height: 20,),
                HeightWidget(
                  onChange: (heightVal) {
                    _height = heightVal;
                  },
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AgeWeightWidget(
                        onChange: (ageVal) {
                          _age = ageVal;
                        },
                        title: "Age",
                        initValue: 30,
                        min: 0,
                        max: 100),
                    AgeWeightWidget(
                        onChange: (weightVal) {
                          _weight = weightVal;
                        },
                        title: "Weight(Kg)",
                        initValue: 50,
                        min: 0,
                        max: 200)
                  ],
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 60),
                  child: SwipeableButtonView(
                    isFinished: _isFinished,
                    onFinish: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          child: ScoreScreen(
                            bmiScore: _bmiScore,
                            age: _age,
                          ),
                          type: PageTransitionType.fade,
                        ),
                      );

                      setState(() {
                        _isFinished = false;
                      });
                    },
                    onWaitingProcess: () {
                      // Calculate BMI here
                      calculateBmi();

                      Future.delayed(Duration(seconds: 1), () {
                        setState(() {
                          _isFinished = true;
                        });
                      });
                    },
                    activeColor: Colors.deepOrange,
                    buttonWidget: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    buttonText: "CALCULATE",
                  ),
                )
              ],
            ),
          ),


    );
  }

  void calculateBmi() {
    _bmiScore = _weight / pow(_height / 100, 2);
  }
}
