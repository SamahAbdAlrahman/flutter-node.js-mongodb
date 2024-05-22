import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../configs.dart';
class EditGymSubscriptionScreen extends StatefulWidget {
  const EditGymSubscriptionScreen({super.key});

  @override
  _EditGymSubscriptionScreenState createState() => _EditGymSubscriptionScreenState();
}
class _EditGymSubscriptionScreenState extends State<EditGymSubscriptionScreen> {
  bool choice1Selected = false;
  bool choice2Selected = false;
  TextEditingController priceController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  Future<void> addSubscription() async {
    if (priceController.text.isNotEmpty &&
        monthController.text.isNotEmpty) {
      final regBody = {
        "price": priceController.text,
        "month": monthController.text,
      };

      final apiUrl = Uri.parse(addSub); // Update the server URL
      try {
        final response = await http.post(
          apiUrl,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        if (response.statusCode == 200) {
          print('sucsess to add subscription: ${response.body}');
fetchSubscriptionOptions();
          // Subscription added successfully
        } else {
fetchSubscriptionOptions();          print('Failed to add subscription: ${response.body}');
          // You can display an error message to the user here
        }
      } catch (error) {
        print('Error: $error');
        // Handle network or other errors
        // You can display an error message to the user here
      }
    }
  }
  List<SubscriptionOptionBox> subscriptionOptions = [];
  @override
  void initState() {
    super.initState();
    fetchSubscriptionOptions();
  }
  Future<void> fetchSubscriptionOptions() async {
    final apiUrl = Uri.parse(getallSub); // Replace with your API endpoint
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final options = data.map((option) => SubscriptionOptionBox.fromJson(option)).toList();

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
  Future<void> deleteClass(String classId) async {
    final apiUrl = Uri.parse('http://192.168.0.114:5000/subscribtion/$classId'); // Update the server URL and endpoint
    try {
      final response = await http.delete(apiUrl);
      await fetchSubscriptionOptions(); // Fetch the updated list of classes

      if (response.statusCode == 200) {
        // Class deleted successfully
        await fetchSubscriptionOptions(); // Fetch the updated list of classes
      } else {
        // Handle errors or display an error message
        print('Failed to delete class: ${response.body}');
        await fetchSubscriptionOptions(); // Fetch the updated list of classes

        // You can display an error message to the user here
      }


    } catch (error) {
      print('Error: $error');
      // Handle network or other errors
      // You can display an error message to the user here
    }
  }
  Future<void> showDeleteConfirmationDialog(BuildContext context, String classId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await deleteClass(classId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
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
                const SizedBox(width: 280),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    showAddSubscriptionDialog(context);
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
                        print("Tapped on box $index");
                      },
                      child: SubscriptionOptionBox(
                        price: subscriptionOptions[index].price,
                        month: subscriptionOptions[index].month,
                        id:  subscriptionOptions[index].id,
                        onDelete: (id) {
                          showDeleteConfirmationDialog(context, id);
                        },
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
                            'Payment by Visa ',
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
                            'On-hand cash',
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
                    onPressed: () {
                      addSubscription();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.orangeAccent),
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

  void showAddSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Subscription'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: monthController,
                decoration: const InputDecoration(labelText: 'Subscription Period'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addSubscription();
                fetchSubscriptionOptions();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class SubscriptionOptionBox extends StatelessWidget {
  final String id; // Add the ID field

  final String price;
  final String month;
  final Function(String) onDelete; // Callback function to handle deletion



  const SubscriptionOptionBox({super.key, 
    required this.price,
    required this.month,
    required this.id, // Add the ID field to the constructor
    required this.onDelete,

  });

  factory SubscriptionOptionBox.fromJson(Map<String, dynamic> json) {
    return SubscriptionOptionBox(
      id: json['_id']?? '', // Parse and store the ID

      price: json['price'],
      month: json['month'],
      onDelete: (String ) {  },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50.0, right: 30, left: 30),
      decoration: BoxDecoration(
        color: Colors.white70,
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
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.black26), // Delete icon
              onPressed: () {
                onDelete(id);

                // Handle delete action here
                // You can show a confirmation dialog before deleting.
              },
            ),
          ],
        ),
      ),
    );
  }
  //_EditGymSubscriptionScreenState sub=_EditGymSubscriptionScreenState();

}



