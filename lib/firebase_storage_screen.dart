import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './provider/database_services.dart';

class FirebaseStorageScreen extends StatefulWidget {
  static const routeName = "/firebase-storage";

  @override
  _FirebaseStorageScreenState createState() => _FirebaseStorageScreenState();
}

class _FirebaseStorageScreenState extends State<FirebaseStorageScreen> {
  String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storage Firebase dan image picker'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (imagePath != null)
                  ? Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black),
                          image: DecorationImage(
                            image: NetworkImage(imagePath),
                            fit: BoxFit.cover,
                          )),
                    )
                  : Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () async {
                  final File file = await getImage();
                  imagePath = await DatabaseServices.uploadImage(file);
                  //imagePath bisa disimpan dalam database
                  print(imagePath);

                  setState(() {});
                },
                child: Text('upload image (must login)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<File> getImage() async {
  //return await ImagePicker.pickImage(source: ImageSource.gallery);
  final picker = ImagePicker();
  final PickedFile pickedFile =
      await picker.getImage(source: ImageSource.gallery);
  return File(pickedFile.path);
}
