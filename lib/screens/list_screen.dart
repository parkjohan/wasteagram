import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../components/entry_list_tile.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int itemCount = 0;
  Future<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('posts').get();

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
      body: ListView(
        children: [
          entryListTile(context, fakeData[0]),
        ],
      ),

      // add new waste fab
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          child: const Icon(
            Icons.camera_enhance,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'photoSelection');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Entry> fakeData = [
    Entry(date: DateFormat.yMMMd().format(DateTime.now()), itemCount: 5),
    Entry(date: DateFormat.yMMMd().format(DateTime.now()), itemCount: 6),
  ];
}

// example list screen data
// formatted date, fake photo, # of items, lat/long
class Entry {
  String date;
  SizedBox fakePhoto = SizedBox(
    height: 100,
    width: 100,
  );
  int itemCount;

  Entry({required this.date, required this.itemCount});
}
