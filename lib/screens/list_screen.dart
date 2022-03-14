import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../components/entry_list_tile.dart';
import '../models/post.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int itemCount = 0;
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection('Posts').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // add new post floating action button
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
        appBar: AppBar(
          centerTitle: true,
          // use stream to count number of items in list (in real time)
          title: StreamBuilder(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                Map<String, dynamic> data =
                        snapshot.data!.docs[i].data()! as Map<String, dynamic>;
                itemCount += int.parse(data['quantity']);
              }
              int totalCount = itemCount;
              itemCount = 0; // reset itemCount so it recounts on every reload
              return Text('Wasteagram - $totalCount');
            },
          ),
        ),
        body: StreamBuilder(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Loading"));
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List entryList = snapshot.data!.docs;
              if (entryList.isNotEmpty) {
                return ListView.builder(
                  itemCount: entryList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        entryList[index].data()! as Map<String, dynamic>;
                    return entryListTile(context, data);
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
