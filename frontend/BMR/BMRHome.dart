import 'package:gofit/BMR/widgets/calculator_brain.dart';
import 'package:gofit/BMR/widgets/constants.dart';
import 'package:gofit/BMR/result.dart';
import 'package:gofit/BMR/widgets/rectangle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:gofit/BMR/theme/custome_theme.dart';
import 'package:gofit/BMR/widgets/circular_card.dart';
import 'package:gofit/BMR/widgets/calculate_button.dart';

class HomeScreenBMR extends StatefulWidget {

  const HomeScreenBMR({super.key});

  @override
  State<HomeScreenBMR> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenBMR> {
  int age = 19;
  int height = 170;
  int weight = 65;
  bool gender = true;

  @override
  Widget build(BuildContext context) {
    theme: CustomTheme();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('BMR Claculater'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: CircularCard(
                    child: Column(children: [
                      const Text(
                        "AGE",
                        style: kTitleTextStyle,
                      ),
                      Expanded(
                        child: Text(age.toString(), style: kLabelTextStyle),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: RectangleIconButton(
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                },
                                icon: kMinusIcon,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: RectangleIconButton(
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                                icon: kAddIcon,
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
                Expanded(

                  child: CircularCard(
                    child: Column(children: [
                      const Text(
                        "WEIGHT (KG)",
                        style: kTitleTextStyle,
                      ),
                      Expanded(
                        child: Text(weight.toString(), style: kLabelTextStyle),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: RectangleIconButton(
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                },
                                icon: kMinusIcon,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: RectangleIconButton(
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                                icon: kAddIcon,
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: CircularCard(
              child: Column(children: [
                const Text(
                  "HEIGHT (CM)",
                  style: kTitleTextStyle,
                ),
                Expanded(
                  child: Text(
                    height.toString(),
                    style: kLabelTextStyle,
                  ),
                ),
                Expanded(
                  child: Slider(
                    inactiveColor: Colors.white54,
                    activeColor: Colors.deepOrange,

                    value: height.toDouble(),
                    onChanged: (value) => setState(() {
                      height = value.toInt();
                    }),
                    min: 120,
                    max: 220,
                  ),
                )
              ]),
            ),
          ),
          Expanded(
            flex: 2,
            child: CircularCard(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "GENDER",
                    style: kTitleTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "I'm",
                        style: kLabelTextStyle,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "FEMALE",
                        style: gender == true
                            ? kTitleTextStyle
                            : kActiveTitleTextStyle,
                      ),
                      Switch(
                          activeColor: Colors.deepOrange,

                          value: gender,
                          onChanged: (value) => setState(() {
                                gender = value;
                              })),
                      Text(
                        "MALE",
                        style: gender == true
                            ? kActiveTitleTextStyle
                            : kTitleTextStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: CalculateButton(
                onTap: () {
                  CalculatorBrain calculatorBrain = CalculatorBrain(
                    age: age,
                    weight: weight,
                    height: height,
                    gender: gender,
                  );

                  print(calculatorBrain.result());

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        bmrResult: calculatorBrain.result(),
                        icon: calculatorBrain.getGenderIcon(),
                      ),
                    ),
                  );
                },
                title: "CALCULATE"),
          ),
        ],
      ),
    );
  }
}
