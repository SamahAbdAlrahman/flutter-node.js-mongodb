import 'package:gofit/BMR/widgets/calculate_button.dart';
import 'package:gofit/BMR/widgets/circular_card.dart';
import 'package:flutter/material.dart';
import 'package:gofit/BMR/widgets/constants.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.bmrResult, required this.icon});

  final String bmrResult;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: CircularCard(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "BMR RESULT",
                    style: kResultLabelTextStyle,
                  ),
                  Text(
                    bmrResult.toString(),
                    style: kResultTextStyle,
                  ),
                  const Text(
                    "CALORIES / DAY",
                    style: kResultSmallTextStyle,
                  ),
                  Icon(
                    icon,
                    size: 100,
                    color: kButtonColor,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: CalculateButton(
                title: "RE-CALCULATE",
                onTap: () {
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }
}
