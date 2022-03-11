// List tile component displaying formatted DateTime.now() and the # of items
import 'package:flutter/material.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import '../screens/list_screen.dart';

ListTile entryListTile(BuildContext context, Entry entry) {
  return ListTile(
    leading: Text(
      entry.date,
      style: Theme.of(context).textTheme.headline5,
    ),
    trailing: Text(entry.itemCount.toString(),
        style: Theme.of(context).textTheme.headline5),
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen()));
    },
  );
}
