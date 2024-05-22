import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/response_row.dart';

class WorkoutDetailView extends StatefulWidget {
  const WorkoutDetailView({super.key});

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView> {
   @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        centerTitle: true,
        elevation: 0.1,

        title: Text(
          "Plank Exercise",
          style: TextStyle(
              color: TColor.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/pp_6.png",
              width: media.width,
              height: media.width * 0.55,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
          '     The plank exercise is a core\n        strengthening workout',
              style: TextStyle(
                color:Color(0xff131e29),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 19),
            Text(
         'Perform the plank exercise by starting facedown, supporting your weight on forearms and toes, maintaining a straight line from head to heels, and holding for as long as possible. Begin with shorter durations and gradually increase over time, focusing on proper form and breathing.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
       ],
    ),
      ),
    );
  }
}
