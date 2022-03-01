import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

// Includes Image Picker, and numerical input for # of items
class _NewPostState extends State<NewPost> {
  Image? image;
  TextEditingController numberOfItemsInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Wasteagram'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                    width: 300,
                    height: 200,
                    child: const Text(
                      'pick photo here...',
                      textAlign: TextAlign.center,
                      style: TextStyle(backgroundColor: Colors.amber),
                    )),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    controller: numberOfItemsInput,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Number of Items',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    child: const Icon(Icons.cloud_upload),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width * 1, 75),
                    ),
                    onPressed: () {},
                  ),
                )),
          ],
        ));
  }
}
