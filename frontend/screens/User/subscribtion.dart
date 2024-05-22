import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../../configs.dart';


class GymSubscriptionScreen extends StatefulWidget {
  const GymSubscriptionScreen({super.key});

  @override
  _GymSubscriptionScreenState createState() => _GymSubscriptionScreenState();
}

class _GymSubscriptionScreenState extends State<GymSubscriptionScreen> {
  bool choice1Selected = false;
  bool choice2Selected = false;
  List<SubscriptionOption> subscriptionOptions = [];
  int selectedBoxIndex = -1; // Index of the selected box

  @override
  void initState() {
    super.initState();
    fetchSubscriptionOptions();
  }

  Future<void> sendNotificationToAdmin() async {
    // Construct the FCM message for the admin
    final token = await getTokenn();

    final message = {
      'notification': {
        'title': 'New Gym Subscription',
        'body': 'A user has subscribed to the gym.',
      },
      'to': 'Bearer $token', // Replace with the admin's FCM token
    };

    final apiUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':"Bearer $token" , // Replace with your FCM server key
    };

    try {
      final response = await http.post(
        apiUrl,
        body: jsonEncode(message),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print('Notification sent to admin');
      } else {
        print('Failed to send notification to admin: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  static Future<String?> getTokenn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  Future<void> fetchSubscriptionOptions() async {
    final apiUrl = Uri.parse('http://192.168.111.1:3000/getallSub'); // Replace with your API endpoint
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final options = data.map((option) => SubscriptionOption.fromJson(option)).toList();

        setState(() {
          subscriptionOptions = options;
        });
      } else {
        // Handle errors or display an error message
        print('Failed to fetch subscription options: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
      // Handle network or other errors
    }
  }
  Future<void> subscribeToGym() async {
    if (selectedBoxIndex >= 0) {
      final selectedSubscription = subscriptionOptions[selectedBoxIndex];

      // Get the user's token (replace with your method to get the token)
      final token = await getTokenn();

      // Calculate the end date based on the selected subscription's number of months
      final startDate = DateTime.now();
      final int months = int.parse(selectedSubscription.month);
      final endDate = startDate.add(Duration(days: months * 30));

      // Define the data to be sent to the API
      final Map<String, dynamic> subscriptionData = {
        "startDate": startDate.toIso8601String(), // Start date
        "endDate": endDate.toIso8601String(),     // End date
        "price": selectedSubscription.price,
        "month": selectedSubscription.month,
      };

      // Define the API endpoint for subscription
      final apiUrl = Uri.parse(allSubscribtion);

      try {
        final response = await http.post(
          apiUrl,
          body: jsonEncode(subscriptionData),
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token", // Include the JWT token
          },
        );

        if (response.statusCode == 200) {
          // Subscription successful, you can handle the response accordingly
          // For example, display a success message.
          print('Subscription successful');
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomSubscriptionDialog(
                startDate: startDate,
                endDate: endDate,
                price: selectedSubscription.price,
                month: selectedSubscription.month,
              );
            },
          );
          // Handle errors or display an error message
          print('Failed to subscribe: ${response.body}');
        }
      } catch (error) {
        print('Error: $error');
        // Handle network or other errors
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/GOFit.jfif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_outlined),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 180.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: subscriptionOptions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle the selection of the box
                          selectedBoxIndex = selectedBoxIndex == index ? -1 : index;
                        });
                      },
                      child: SubscriptionOption(
                        price: subscriptionOptions[index].price,
                        month: subscriptionOptions[index].month,
                        isSelected: selectedBoxIndex == index, // Pass the selection state
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: choice1Selected,
                            onChanged: (value) {
                              setState(() {
                                choice1Selected = value!;
                              });
                            },
                          ),
                          const Text(
                            'payment by Visa ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: choice2Selected,
                            onChanged: (value) {
                              setState(() {
                                choice2Selected = value!;
                              });
                            },
                          ),
                          const Text(
                            'on hand cash',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: sendNotificationToAdmin,

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      elevation: MaterialStateProperty.all(4.0),
                    ),
                    child: const Text(
                      'Subscribe',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionOption extends StatelessWidget {
  final String price;
  final String month;
  final bool isSelected;

  const SubscriptionOption({super.key, required this.price, required this.month, required this.isSelected});

  factory SubscriptionOption.fromJson(Map<String, dynamic> json) {
    return SubscriptionOption(
      price: json['price'],
      month: json['month'],
      isSelected: false, // Set isSelected initially to false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 70.0, right: 30, left: 30),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orangeAccent : Colors.white70, // Change color based on isSelected
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orangeAccent.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Price: $price',
              style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
            ),
            Text(
              'Months: $month',
              style: const TextStyle(fontSize: 16, color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSubscriptionDialog extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String price;
  final String month;

  const CustomSubscriptionDialog({super.key, 
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    final dateFormat = DateFormat('dd-MM-yyyy'); // Define the date format here

    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ],
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
          Image.asset('assets/img/true.gif', height: 100, width: 100),
          const Text(' Your Subscription Valid', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            Row(children: [

              const SizedBox(width: 10),

              Text('From: ${dateFormat.format(startDate)}',style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              const SizedBox(width: 10),

              Text('to: ${dateFormat.format(endDate)}',style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            ],),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style:ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),

              ) ,
              child: const Text('OK'),
            ),
            ],
          ),
        ),
      ],
    );
  }
}
