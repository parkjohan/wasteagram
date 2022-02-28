import 'dart:ffi';

import 'package:flutter/material.dart';

class EntryListView extends StatefulWidget {
  const EntryListView({Key? key}) : super(key: key);

  @override
  _EntryListViewState createState() => _EntryListViewState();
}

class _EntryListViewState extends State<EntryListView> {
  int itemCount = 0;



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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_enhance),
        onPressed: () {
          
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
