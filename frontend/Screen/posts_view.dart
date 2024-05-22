import 'package:gofit/Blog/Blogs.dart';
import 'package:flutter/material.dart';
class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  _PostsViewState createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEFF),
      body: SingleChildScrollView(
        child: Blogs(
          key: UniqueKey(), // Pass a unique Key here
          url: "/blogpost/getOtherBlog",
        ),
      ),
    );
  }
}
