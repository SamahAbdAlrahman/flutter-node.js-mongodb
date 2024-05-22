import 'package:flutter/material.dart';

import 'armExcercise.dart';

class userExercise extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('Categories'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: ContainerColumnPage(),
        ),
      ),
    );
  }
}

class ContainerColumnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArmExcercise(),
                ),
              );
              // Add your onPressed logic for Button 1
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/img/arm.png',
                  height: 150.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 60.0),
                  child: Text(
                    'ARM EXERCISE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Add your onPressed logic for Button 2
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/img/chest.png',
                  height: 150.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 60.0),
                  child: Text(
                    'CHEST EXERCISE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Add your onPressed logic for Button 3
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/img/leg.png',
                  height: 150.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 60.0),
                  child: Text(
                    'LEG EXERCISE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          ElevatedButton(
            onPressed: () {
              // Add your onPressed logic for Button 1
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/img/sixback.png',
                  height: 150.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 60.0),
                  child: Text(
                    'SIX BACK EXERCISE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Add more buttons as needed
        ],
      ),
    );
  }
}
