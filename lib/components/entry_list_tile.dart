// List tile component displaying formatted DateTime.now() and the # of items
import 'package:flutter/material.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import '../screens/list_screen.dart';
import '../models/post.dart';

ListTile entryListTile(BuildContext context, Post post) {
  return ListTile(
    leading: Text(
      post.date,
      style: Theme.of(context).textTheme.headline5,
    ),
    trailing: Text(post.itemCount.toString(),
        style: Theme.of(context).textTheme.headline5),
    onTap: () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailScreen(post: post)));
    },
  );
}
