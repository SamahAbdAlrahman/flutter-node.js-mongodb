import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart'; // Import the intl package

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../configs.dart';

class EditSportsLessonsPage extends StatefulWidget {
  const EditSportsLessonsPage({super.key});

  @override
  _SportsLessonsPageState createState() => _SportsLessonsPageState();
}

class _SportsLessonsPageState extends State<EditSportsLessonsPage> {
  TextEditingController imagePathController = TextEditingController();
  TextEditingController classNameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController coachNameController = TextEditingController();
  TextEditingController allowedNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();




  List<ClassData> classes = [];

  int maxSubscribers = 20;
  int subscribersCount = 15;
  ValueNotifier<int> currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    // Fetch class data when the screen loads
    fetchClasses();
  }
  Future<void> addNewClass() async {
    if (imagePathController.text.isNotEmpty &&
        classNameController.text.isNotEmpty &&
        timeController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        costController.text.isNotEmpty &&
        coachNameController.text.isNotEmpty &&
        allowedNumberController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      final regBody = {
        "imagePath": imagePathController.text,
        "ClassName": classNameController.text,
        "time": timeController.text,
        "Date": dateController.text,
        "cost": costController.text,
        "cotchName": coachNameController.text,
        "allowedNumber": allowedNumberController.text,
        "description": descriptionController.text,
      };

      final apiUrl = Uri.parse(addClass); // Update the server URL
      try {
        final response = await http.post(
          apiUrl,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        if (response.statusCode == 200) {
          // Class added successfully
          fetchClasses();
          Navigator.of(context).pop(); // Close the dialog
        } else {
          // Handle errors or display an error message
          print('Failed to add class: ${response.body}');
          // You can display an error message to the user here
        }
      } catch (error) {
        print('Error: $error');
        // Handle network or other errors
        // You can display an error message to the user here
      }
    }
  }
  Future<void> deleteClass(String classId) async {
    final apiUrl = Uri.parse('http://192.168.0.114:5000/class/$classId'); // Update the server URL and endpoint
    try {
      final response = await http.delete(apiUrl);
      await fetchClasses(); // Fetch the updated list of classes

      if (response.statusCode == 200) {
        // Class deleted successfully
        await fetchClasses(); // Fetch the updated list of classes
      } else {
        // Handle errors or display an error message
        print('Failed to delete class: ${response.body}');
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
          content: const Text('Are you sure you want to delete this class?'),
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


  Future<void> fetchClasses() async {
    final response = await http.get(Uri.parse(getClasses));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      classes = data.map((json) => ClassData.fromJson(json)).toList();

      setState(() {});
    } else {
      // Handle the error if the request fails
      print('Failed to fetch classes');
    }
  }
  void showAddLessonDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Add New Class',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: imagePathController,
                        decoration: const InputDecoration(
                          labelText: 'Image Path',
                          icon: Icon(Icons.image),

                          // border: OutlineInputBorder(),
                        ),
                          readOnly: true,
                          onTap: () async{
                            final ImagePicker picker = ImagePicker();
                            try {
                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                              if (image != null) {
                                imagePathController.text = image.path;
                              } else {
                                print('No image selected.');
                              }
                            } catch (e) {
                              print('Error selecting image: $e');
                            }
                          }
                      ),
                    ),

                  ],
                ),
                TextField(
                  controller: classNameController,
                  decoration: const InputDecoration(
                    labelText: 'Class Name',
                    icon: Icon(Icons.label),


                    // border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(
                    labelText: 'Time',
                    icon: Icon(Icons.timer),

                   // border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(

                   labelText: 'Date',
                      icon: Icon(Icons.calendar_today_rounded),

                   // border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    // Show a date picker to select the date.
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (selectedDate != null) {
                      // Format the selected date and set it in the controller.
                      dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    }
                  },
                ),
                TextField(
                  controller: costController,
                  decoration: const InputDecoration(
                    labelText: 'Cost',
                    icon: Icon(Icons.price_change_rounded),

                   // border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: coachNameController,
                  decoration: const InputDecoration(
                    labelText: 'Coach Name',
                    icon: Icon(Icons.person),

                   // border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: allowedNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Allowed Number',
                    icon: Icon(Icons.numbers_outlined),

                   // border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    icon: Icon(Icons.description),

                   // border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        await addNewClass();
                        await fetchClasses();
                        Navigator.of(context).pop();
                      },

                      child: const Text('Add', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent, // تخصيص لون النص
                      ),),
                    ),
                    TextButton(
                      onPressed: () {
                        // Close the dialog without performing any action
                        Navigator.of(context).pop();
                      },

                      child: const Text('Cancel', style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.orangeAccent, // تخصيص لون النص
        ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        );
      },
    );
  }
  Future<void> showEditLessonDialog(BuildContext context, ClassData classData) async {
    // Initialize text editing controllers with the current values
    TextEditingController editedimagepathController = TextEditingController(text: classData.imagePath);

    TextEditingController editedClassNameController = TextEditingController(text: classData.className);
    TextEditingController editedTimeController = TextEditingController(text: classData.time);
    TextEditingController editedDateController = TextEditingController(text: classData.date);
    TextEditingController editedCostController = TextEditingController(text: classData.cost);
    TextEditingController editedCoachNameController = TextEditingController(text: classData.coachName);
    TextEditingController editedAllowedNumberController = TextEditingController(text: classData.allowedNumber.toString());
    TextEditingController editedDescriptionController = TextEditingController(text: classData.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Edit Class Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: editedimagepathController,
                          decoration: const InputDecoration(
                            labelText: 'Image Path',
                            icon: Icon(Icons.image),

                            // border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: () async{
                            final ImagePicker picker = ImagePicker();
                            try {
                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                              if (image != null) {
                                editedimagepathController.text = image.path;
                              } else {
                                print('No image selected.');
                              }
                            } catch (e) {
                              print('Error selecting image: $e');
                            }
                          },
                        ),
                      ),

                    ],
                  ),
                  TextField(
                    controller: editedClassNameController,
                    decoration: const InputDecoration(
                      labelText: 'Class Name',
                      icon: Icon(Icons.label),

                    ),
                  ),
                  TextField(
                    controller: editedTimeController,
                    decoration: const InputDecoration(
                      labelText: 'Time',
                      icon: Icon(Icons.timer),

                    ),
                  ),
                  TextField(
                    controller: editedDateController,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      icon: Icon(Icons.calendar_today_rounded),

                    ),

                    readOnly: true,
                    onTap: () async {
                      // Show a date picker to select the date.
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (selectedDate != null) {
                        // Format the selected date and set it in the controller.
                        editedDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                      }
                    },
                  ),
                  TextField(
                    controller: editedCostController,
                    decoration: const InputDecoration(
                      labelText: 'Cost',
                      icon: Icon(Icons.price_change_rounded),

                    ),
                  ),
                  TextField(
                    controller: editedCoachNameController,
                    decoration: const InputDecoration(
                      labelText: 'Coach Name',
                      icon: Icon(Icons.person),

                    ),
                  ),
                  TextField(
                    controller: editedAllowedNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Allowed Number',
                      icon: Icon(Icons.numbers_outlined),

                    ),
                  ),
                  TextField(
                    controller: editedDescriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      icon: Icon(Icons.description),

                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          await updateClass(classData.id, {
                            "imagePath":editedimagepathController.text,
                            "ClassName": editedClassNameController.text,
                            "time": editedTimeController.text,
                            "Date": editedDateController.text,
                            "cost": editedCostController.text,
                            "cotchName": editedCoachNameController.text,
                            "allowedNumber": int.parse(editedAllowedNumberController.text),
                            "description": editedDescriptionController.text,
                          });
                          await fetchClasses();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Close the dialog without performing any action
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Future<void> updateClass(String classId, Map<String, dynamic> updatedData) async {
    final apiUrl = Uri.parse('http://192.168.0.114:5000/updateClass/$classId'); // Update the server URL and endpoint
    try {
      final response = await http.put(
        apiUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        // Class updated successfully
        await fetchClasses(); // Fetch the updated list of classes
      } else {
        // Handle errors or display an error message
        print('Failed to update class: ${response.body}');
        // You can display an error message to the user here
      }
    } catch (error) {
      print('Error: $error');
      // Handle network or other errors
      // You can display an error message to the user here
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
          children: <Widget>[
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
                const SizedBox(width: 280), // إضافة مسافة أفقية بين الأيقونات

                Positioned(
                  top: 20, // Adjust the position as needed
                  right: 20, // Adjust the position as needed
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,size: 40,
                    ),
                    onPressed: () {
                      showAddLessonDialog(context);
                      // Add your functionality here when the button is pressed
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 180.0),
            Expanded(
              child: PageView.builder(
                itemCount: classes.length,
                onPageChanged: (int page) {
                  currentPage.value = page;
                },
                itemBuilder: (context, index) {
                  return ValueListenableBuilder<int>(
                    valueListenable: currentPage,
                    builder: (context, page, child) {
                      final isCurrentPage = index == page;
                      final elevation = isCurrentPage ? 8.0 : 0.0;

                      return buildLessonCard(classes[index]);

                    },
                  );
                },
              ),
            ),

          ],

        ),

      ),
    );
  }

  Widget buildLessonCard(
      ClassData classData,
      {double elevation = 0.0}
      ) {
    Color borderColor = Colors.grey; // لون الحدود
    double borderWidth = 2.0; // سمك الحدود
    bool isBookingConfirmed = false; // تمثل حالة تأكيد الحجز


    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(15),
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child:
              Image.file(File(classData.imagePath),
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/placeholder_image.png'); // Show a placeholder image on error
                },
              )
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    classData.className,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // color: borderColor, // لون الحدود
                          border: Border.all(
                            color: borderColor, // لون الحدود
                            width: borderWidth, // سمك الحدود
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(classData.time),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // color: borderColor, // لون الحدود
                          border: Border.all(
                            color: borderColor, // لون الحدود
                            width: borderWidth, // سمك الحدود
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child:
                        Text(classData.date),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // color: borderColor, // لون الحدود
                          border: Border.all(
                            color: borderColor, // لون الحدود
                            width: borderWidth, // سمك الحدود
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child:
                        Text(classData.cost),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // color: borderColor, // لون الحدود
                          border: Border.all(
                            color: borderColor, // لون الحدود
                            width: borderWidth, // سمك الحدود
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(classData.coachName),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  LinearProgressIndicator(
                    value: subscribersCount / maxSubscribers,
                    valueColor: const AlwaysStoppedAnimation(Colors.green),
                    backgroundColor: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$subscribersCount / $maxSubscribers مشترك',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(classData.description),

                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                    ),
                    child: const Text('booking'),

                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black26), // Edit icon
                        onPressed: () {
                          showEditLessonDialog(context, classData);

                          // Handle edit action here
                          // You can open an edit dialog or navigate to an edit screen.
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.black26), // Delete icon
                        onPressed: () {
                          showDeleteConfirmationDialog(context, classData.id);

                          // Handle delete action here
                          // You can show a confirmation dialog before deleting.
                        },
                      ),
                    ],
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
class ClassData {
  final String id; // Add the ID field

  final String imagePath;
  final String className;
  final String time;
  final String date;
  final String cost;
  final String coachName;
  final int allowedNumber;
  final String description;

  ClassData({
    required this.id, // Add the ID field to the constructor

    required this.imagePath,
    required this.className,
    required this.time,
    required this.date,
    required this.cost,
    required this.coachName,
    required this.allowedNumber,
    required this.description,
  });

  factory ClassData.fromJson(Map<String, dynamic> json) {
    return ClassData(
      id: json['_id']?? '', // Parse and store the ID

      imagePath: json['imagePath'],
      className: json['ClassName'],
      time: json['time'],
      date: json['Date'],
      cost: json['cost'],
      coachName: json['cotchName'],
      allowedNumber: json['allowedNumber'],
      description: json['description'],
    );
  }
}








class LinearProgressContainer extends StatelessWidget {
  final double value;
  final Color color;

  const LinearProgressContainer({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: LinearProgressIndicator(
        value: value,
        valueColor: AlwaysStoppedAnimation(color),
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}
