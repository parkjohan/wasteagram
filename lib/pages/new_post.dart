import 'package:flutter/material.dart';

class NewPost extends StatelessWidget {
  const NewPost({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Wasteagram'),),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            child: Icon(Icons.cloud_upload),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 50),
            ),
            onPressed: () {
              
            },
          ),
        )
      )
    );
  }
}