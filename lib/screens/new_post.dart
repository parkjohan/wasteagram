import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import '../models/post.dart';

import '../components/share_location.dart';
import '../components/get_formatted_date.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

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

  final formKey = GlobalKey<FormState>();
  var post = Post();
  var locationData = ShareLocation();

  @override
  void initState() {
    super.initState();
    locationData.retrieveLocation();
  }

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
    uploadedFile.ref.getDownloadURL().then((value) {
      post.imageURL = value;
      print(post.imageURL);
    });
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
                  child: Form(
                    key: formKey,
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
                        } else if (int.parse(value) <= 0) {
                          return 'Value must be greater than 0!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        post.itemCount = value;
                      },
                    ),
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          post.date =
                              DateFormat.yMMMEd().format(DateTime.now());
                          // itemCount saved
                          // imageURL saved
                          post.latitude =
                              locationData.locationData!.latitude.toString();
                          post.longitude =
                              locationData.locationData!.longitude.toString();
                          // Save post data to a new firestore document
                          FirebaseFirestore.instance
                              .collection('Posts')
                              .doc()
                              .set({
                            'date': post.date,
                            'imageURL': post.imageURL,
                            'latitude': post.latitude,
                            'longitude': post.longitude,
                            'quantity': post.itemCount,
                          });
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        }
                      }),
                )),
          ],
        ));
  }

  Widget pickPhotoGestureBox() {
    return GestureDetector(
      child: const DecoratedBox(
        decoration: BoxDecoration(color: Colors.grey),
        child: Center(
          child: Text(
            'Select photo...',
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
