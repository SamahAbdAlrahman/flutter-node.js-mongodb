// import 'dart:convert';
// import 'dart:io';
//
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
//
// import '../CustumWidget/OverlayCard.dart';
// import '../Model/addBlogModels.dart';
// import '../NetworkHandler.dart';
//
// class AddBlog extends StatefulWidget {
//   const AddBlog({super.key});
//
//   @override
//   _AddBlogState createState() => _AddBlogState();
// }
//
// class _AddBlogState extends State<AddBlog> {
//   final _globalkey = GlobalKey<FormState>();
//   final TextEditingController _title = TextEditingController();
//   final TextEditingController _body = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   PickedFile? _imageFile;
//   IconData iconphoto = Icons.add_photo_alternate_outlined;
//   NetworkHandler networkHandler = NetworkHandler();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//         // automaticallyImplyLeading: false, // Hide the back arrow
//         // backgroundColor: Color.fromARGB(255, 190, 89, 35),
//         backgroundColor: Colors.transparent,
//         // backgroundColor: Color.fromARGB(255, 243, 92, 10),
//         title: Text(
//           "Add Post",
//           style: TextStyle(
//               color:
//           Colors.black87,
//               fontWeight: FontWeight.w700
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Form(
//         key: _globalkey,
//         child: ListView(
//           children: <Widget>[
//
//             const SizedBox(
//               height: 20,
//             ),
//             titleTextField(),
//             bodyTextField(),
//             const SizedBox(
//               height: 30,
//             ),
//             TextButton(
//               onPressed: () async {
//                 if (_imageFile != null && _globalkey.currentState!.validate()) {
//                   try {
//                     final imageFile = _imageFile!;
//                    // show here
//                 //     _title.text,
//                 //     imageFile,
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text('Preview Post',
//                             style: TextStyle(
//                               // fontSize: 16,  // Set your preferred font size
//                            // fontWeight: FontWeight.bold, // Set your preferred font weight
//                               color: Colors.deepOrange, // Set your preferred text color
//                             ),
//                           ),
//                           content: Container(
//                             width: 3450, // Set your preferred width
//                             height: 360, // Set your preferred height
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               // mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//
//                                 Image.file(
//                                   File(imageFile.path),
//                                   height: 250,
//                                   width: 300,
//                                   // fit: BoxFit.fitHeight,
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text('Title:${_title.text}',
//                                   style: TextStyle(
//                                     fontSize: 16,  // Set your preferred font size
//                                     fontWeight: FontWeight.normal,
//                                     // Set your preferred font weight
//                                     color: Colors.black, // Set your preferred text color
//                                   ),),
//
//                                 SizedBox(height: 2),
//                                 Text('Body:${_body.text}'
//                                  , style: TextStyle(
//                                   fontSize: 16,  // Set your preferred font size
//                                   fontWeight: FontWeight.normal, // Set your preferred font weight
//                                   color: Colors.black, // Set your preferred text color
//                                 ),),
//                               ],
//                             ),
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context); // Close the dialog
//                               },
//                               child: Text('OK',  style: TextStyle(
//                                 fontSize: 16,  // Set your preferred font size
//                                 fontWeight: FontWeight.normal, // Set your preferred font weight
//                                 color: Colors.deepOrange, // Set your preferred text color
//                               ),),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   } catch (e) {
//                     // Handle any exceptions that might occur
//                     print("Error: $e");
//                   }
//                 }
//               },
//               child: const Text(
//                 "Preview",
//                 style: TextStyle(
//                   fontSize: 18,
//                   color:Colors.deepOrange,
//                   fontWeight: FontWeight.bold,
//                     ),
//               ),
//               style: ButtonStyle(
//                 alignment: Alignment.center, // Align the text to the right
//               ),
//             ),
//             const SizedBox(
//               height: 60,
//             ),
//             addButton(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget titleTextField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 25,
//         vertical: 50,
//       ),
//       child: TextFormField(
//         controller: _title,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return "Title can't be empty";
//           } else if (value.length > 100) {
//             return "Title length should be <= 100";
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           // border: const OutlineInputBorder(
//           //   borderSide: BorderSide(
//           //     color:      Colors.grey,
//           //   ),
//           // ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.deepOrange,
//               width: 2,
//             ),
//           ),
//           labelText: "Add Image and Title",
//           labelStyle: TextStyle(
//             color: Colors.black54, // Change label text color
//             fontSize: 15,       // Change label text font size
//             // fontWeight: FontWeight.bold, // Change label text font weight
//           ),
//           prefixIcon: IconButton(
//             icon: Icon(
//               iconphoto,
//               color:        const Color.fromRGBO(248, 96, 2, 1.0),
//             ),
//             onPressed: takeCoverPhoto,
//           ),
//         ),
//         maxLength: 100,
//         maxLines: null,
//       ),
//     );
//   }
//
//   Widget bodyTextField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 35,
//         // vertical:10,
//
//       ),
//       child: TextFormField(
//         controller: _body,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return "Body can't be empty";
//           }
//           return null;
//         },
//         decoration: const InputDecoration(
//                 focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.deepOrange,
//               width: 2,
//             ),
//           ),
//           labelText: "Provide Body for Your Post",
//           labelStyle: TextStyle(
//             color: Colors.black54, // Change label text color
//             fontSize: 15,       // Change label text font size
//             // fontWeight: FontWeight.bold, // Change label text font weight
//           ),
//         ),
//         maxLines: null,
//       ),
//     );
//   }
//
//   Widget addButton() {
//     return InkWell(
//       onTap: () async {
//         if (_imageFile != null && _globalkey.currentState!.validate()) {
//           AddBlogModel addBlogModel =
//           AddBlogModel(body: _body.text, title: _title.text);
//           var response = await networkHandler.post1(
//               "/blogpost/Add", addBlogModel.toJson());
//           print(response.body);
//
//           if (response.statusCode == 200 || response.statusCode == 201) {
//             String id = json.decode(response.body)["data"];
//             var imageResponse = await networkHandler.patchImage(
//                 "/blogpost/add/coverImage/$id", _imageFile!.path);
//             print(imageResponse.statusCode);
//             if (imageResponse.statusCode == 200 ||
//                 imageResponse.statusCode == 201) {
//
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text("The post has been added successfully"),
//                   duration: Duration(seconds: 4), // You can adjust the duration as needed
//                 ),
//               );
//             }
//           }
//         }
//       },
//       child: Center(
//
//         child: Container(
//           height: 55,55
//           width: 230,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(24),
//             gradient: const LinearGradient(
//               colors: [
//                 Color(0xff000207),
//                 // Color(0xffff7300),
//                 Color(0xffff6200),
//               ],
//             ),
//           ),
//           child: const Center(
//             child: Text(
//               'Add Post',
//               style: TextStyle(
//                 // fontWeight: FontWeight.bold,
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//
//     );
//   }
//   void takeCoverPhoto() async {
//     final coverPhoto = await _picker.pickImage(source: ImageSource.gallery);
//     if (coverPhoto != null) {
//       setState(() {
//         _imageFile = PickedFile(coverPhoto.path);
//         iconphoto = Icons.check_box;
//       });
//     }
//   }
//
//
// }
