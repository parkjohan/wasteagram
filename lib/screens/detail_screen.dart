import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  // Retrieve post details from entry_list_tile
  Map<String, dynamic> post;
  DetailScreen({Key? key, required this.post}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 50,
                child: Center(
                    child: Text(
                  post['date'],
                  style: Theme.of(context).textTheme.headline5,
                )),
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: Container(
                    child: Center(child: Image.network(post['imageURL']))),
              ),
              SizedBox(
                height: 50,
                child: Center(
                  child: Text('Items: ${post['quantity']}', style: Theme.of(context).textTheme.headline5),
                ),
              ),
              SizedBox(
                height: 50,
                child: Center(
                  child: Text('Location: (${post['latitude']}, ${post['longitude']})',
                  style: Theme.of(context).textTheme.headline6),
                ),
              )
            ],
          ),
        ));
  }
}
