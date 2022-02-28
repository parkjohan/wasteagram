import 'package:flutter/material.dart';

class EntryListView extends StatefulWidget {
  const EntryListView({ Key? key }) : super(key: key);

  @override
  _EntryListViewState createState() => _EntryListViewState();
}

class _EntryListViewState extends State<EntryListView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Welcome"),
    );
  }
}