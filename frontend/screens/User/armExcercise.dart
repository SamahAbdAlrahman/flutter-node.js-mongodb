import 'package:flutter/material.dart';

import 'UserExcercise.dart';
import 'detailes.dart';

class ArmExcercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        /*appBar: AppBar(
          title: Text('ARM EXCERCISE'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),*/
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
          SizedBox(height: 20,),
          Row(children: [

            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => userExercise(),
                  ),
                );              },
            ),
            SizedBox(width: 10,),
            Text('ARM EXCERCISE',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
          ],),
SizedBox(height:20 ,),
          ElevatedButton(
            onPressed: () {
              // Add your onPressed logic for Button 1
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white70, // Set button color to white
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                // Image on the left
                Container(
                  width: 120.0, // Adjust the width as needed
                  height: 120.0, // Adjust the height as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage('assets/img/push.png'),
                      fit: BoxFit.cover,

                    ),
                  ),
                ),
                SizedBox(width: 60.0), // Add spacing between image and details
                // Details on the right
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,)
,                      Text(
                        'Push up',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Time: 10 mins',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45// Make the title bold
                        ),
                      ),
                      Divider(
                        thickness: 2.0,
                        color: Colors.grey,
                        indent: 18.0, // Adjust the indent as needed
                        endIndent: 16.0, // Adjust the end indent as needed
                      ),
                      //SizedBox(height: 8.0),
                      Text(
                        'Calories:  400 🔥',
                        style: TextStyle(fontSize: 16.0,
                            color: Colors.black45// Make the title bold

                        ),
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => detailes(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],

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
              primary: Colors.white70, // Set button color to white
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                // Image on the left
                Container(
                  width: 120.0, // Adjust the width as needed
                  height: 120.0, // Adjust the height as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage('assets/img/hammer.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 60.0), // Add spacing between image and details
                // Details on the right
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        'Hammer Curl',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Time: 15 mins',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                            color: Colors.black45// Make the title bold
// Make the title bold
                        ),
                      ),
                      Divider(
                        thickness: 2.0,
                        color: Colors.grey,
                        indent: 18.0, // Adjust the indent as needed
                        endIndent: 16.0, // Adjust the end indent as needed
                      ),
                      //SizedBox(height: 8.0),
                      Text(
                        'Calories:  340 🔥',
                        style: TextStyle(fontSize: 16.0,        color: Colors.black45// Make the title bold
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => detailes(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],

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
              primary: Colors.white70, // Set button color to white
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                // Image on the left
                Container(
                  width: 120.0, // Adjust the width as needed
                  height: 120.0, // Adjust the height as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage('assets/img/tricep.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 60.0), // Add spacing between image and details
                // Details on the right
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),

                      Text(
                        'tricep dips',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Time: 12 mins',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,   color: Colors.black45// Make the title bold
                          // Make the title bold
                        ),
                      ),
                      Divider(
                        thickness: 2.0,
                        color: Colors.grey,
                        indent: 18.0, // Adjust the indent as needed
                        endIndent: 16.0, // Adjust the end indent as needed
                      ),
                      //SizedBox(height: 8.0),
                      Text(
                        'Calories:  400 🔥',
                        style: TextStyle(fontSize: 16.0,  color: Colors.black45// Make the title bold
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => detailes(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],

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
              primary: Colors.white70, // Set button color to white
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                // Image on the left
                Container(
                  width: 120.0, // Adjust the width as needed
                  height: 120.0, // Adjust the height as needed
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage('assets/img/tricep1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 60.0), // Add spacing between image and details
                // Details on the right
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),

                      Text(
                        'tricep extentions',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Time: 12 mins',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,                             color: Colors.black45// Make the title bold
// Make the title bold
                        ),
                      ),
                      Divider(
                        thickness: 2.0,
                        color: Colors.grey,
                        indent: 18.0, // Adjust the indent as needed
                        endIndent: 16.0, // Adjust the end indent as needed
                      ),
                      //SizedBox(height: 8.0),
                      Text(
                        'Calories:  350 🔥',
                        style: TextStyle(fontSize: 16.0,                            color: Colors.black45// Make the title bold
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => detailes(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],

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
              primary: Colors.white70, // Set button color to white
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                // Image on the left
                Container(
                  width: 120.0, // Adjust the width as needed
                  height: 170.0, // Adjust the height as needed
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage('assets/img/bicep.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 60.0), // Add spacing between image and details
                // Details on the right
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),

                      Text(
                        'bicep curl',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Time: 12 mins',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,                            color: Colors.black45// Make the title bold
                          // Make the title bold
                        ),
                      ),
                      Divider(
                        thickness: 2.0,
                        color: Colors.grey,
                        indent: 18.0, // Adjust the indent as needed
                        endIndent: 16.0, // Adjust the end indent as needed
                      ),
                      //SizedBox(height: 8.0),
                      Text(
                        'Calories:  350 🔥',
                        style: TextStyle(fontSize: 16.0,                            color: Colors.black45// Make the title bold
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => detailes(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],

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
