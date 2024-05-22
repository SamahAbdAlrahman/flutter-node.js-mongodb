import 'package:gofit/Blog/Blog.dart';
import 'package:gofit/CustumWidget/BlogCard.dart';
import 'package:gofit/Model/SuperModel.dart';
import 'package:gofit/Model/addBlogModels.dart';
import 'package:gofit/NetworkHandler.dart';
import 'package:flutter/material.dart';
class Blogs extends StatefulWidget {
  const Blogs({ super.key, required this.url });
  final String url;

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<AddBlogModel> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  void fetchData() async {
    var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data!.whereType<AddBlogModel>().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? Column(
      children: data
          .map((item) => Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) => Blog(
                        addBlogModel: item,
                        networkHandler: networkHandler,
                      )));
            },
            child: BlogCard(
              addBlogModel: item,
              networkHandler: networkHandler,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ))
          .toList(),
    )
        : const Center(
      child: Text("We don't have any Blog Yet"),
    );
  }
}