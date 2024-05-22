import 'package:gofit/Model/addBlogModels.dart';
import 'package:gofit/NetworkHandler.dart';
import 'package:flutter/material.dart';

class Blog extends StatefulWidget {
  const Blog({
    super.key,
    required this.addBlogModel,
    required this.networkHandler,
  });

  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;

  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  bool isCommenting = false;
  TextEditingController commentController = TextEditingController();
  List<String> comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:   const Color.fromRGBO(255, 81, 0, 1.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: widget.networkHandler.getImage(widget.addBlogModel.id as String),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.addBlogModel.title as String,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isCommenting = true;
                      });
                    },
                    child: const Icon(
                      Icons.chat_bubble,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.addBlogModel.comment.toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(width: 15),
                  const Icon(
                    Icons.thumb_up,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.addBlogModel.count.toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(width: 15),
                  const Icon(
                    Icons.share,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.addBlogModel.share.toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(16),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(widget.addBlogModel.body as String),
                ),
              ),
            ),
            if (isCommenting)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                    hintText: 'Write a comment...',
                  ),
                ),
              ),
            if (isCommenting)
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromRGBO(246, 87, 14, 1.0),
                ),
                child: const Center(
                  child: Text(
                    "Add Comment",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            if (comments.isNotEmpty)
              Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: comments
                      .map((comment) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(comment),
                    ),
                  ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
