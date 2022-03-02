import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../components/get_formatted_date.dart';

class NewPost extends StatefulWidget {
  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final ImagePicker _picker = ImagePicker();

  // Holds the image file
  File? image;
  String? imageURL;

  // Number text field controller
  TextEditingController numberOfItemsInput = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // method to pick an image from device gallery
  void pickImage() async {
    XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    image = File(selectedImage!.path);
    uploadImageToStorage(image!);
    // trigger rebuild to update image
    setState(() {});
  }

  //
  Future<void> uploadImageToStorage(File file) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(basename(image!.path));
    TaskSnapshot uploadedFile = await firebaseStorageRef
        .putFile(file)
        .whenComplete(() => print('done uploading!'));
    uploadedFile.ref.getDownloadURL().then((value) => print(value));
  }

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
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 300,
                    height: 200,
                    child:
                        image == null ? pickPhotoGestureBox() : displayImage()),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    controller: numberOfItemsInput,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Number of Items',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty!';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    child: const Icon(Icons.cloud_upload),
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.75, 75),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(
                            'putting image and item count data into firestore...');
                      }
                    },
                  ),
                )),
          ],
        ));
  }

  Widget pickPhotoGestureBox() {
    return GestureDetector(
      child: const DecoratedBox(
        decoration: BoxDecoration(color: Colors.pink),
        child: Center(
          child: Text(
            'pick photo here...',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        print('picking image...');
        pickImage();
      },
    );
  }

  Widget displayImage() {
    return Container(
      child: Image.file(
        image!,
        fit: BoxFit.fill,
      ),
    );
  }
}
