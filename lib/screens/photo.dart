import 'package:flutter/material.dart';

class PhotoSelection extends StatelessWidget {
  const PhotoSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Wasteagram'),
      ),
      body: Center(
        child: InkWell(
          child: Text(
            'Choose photo or take photo',
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          onTap: () {
            Navigator.pushNamed(context, 'newPost');
          },
        ),
      ),
    );
  }
}
