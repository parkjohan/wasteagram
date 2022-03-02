import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int itemCount = 0;
  Future<QuerySnapshot> posts = FirebaseFirestore.instance.collection('posts').get();

  @override
  void initState() {
    super.initState();
    setItemCount();
  }

  void setItemCount() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wasteagram - $itemCount'),
      ),
      body: Center(
        child: Text("Welcome"),
      ),

      // add new waste fab
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          child: const Icon(Icons.camera_enhance, size: 30,),
          onPressed: () {
            Navigator.pushNamed(context, 'photoSelection');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
