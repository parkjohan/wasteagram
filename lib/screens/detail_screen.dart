import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  // Retrieve post details from entry_list_tile
  final post;
  const DetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Wasteagram'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Center(
                    child: Text(
                  post.date,
                )),
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: Container(decoration: BoxDecoration(color: Colors.blueAccent), child: Center(child: Text(post.imageURL))),
              ),
              SizedBox(
                height: 50,
                child: Center(
                  child: Text('Items: ${post.itemCount}'),
                ),
              ),
              SizedBox(
                height: 50,
                child: Center(
                  child: Text('(${post.latitude}, ${post.longitude})'),
                ),
              )
            ],
          ),
        ));
  }
}
