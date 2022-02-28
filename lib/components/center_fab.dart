import 'package:flutter/material.dart';

class CenterFloatingActionButton extends StatelessWidget {
  const CenterFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
