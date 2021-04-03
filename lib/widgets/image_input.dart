import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  //File adalah milik 'dart:io', untuk tampung file yg diambil dari kamera
  File _storedImage;

  Future<void> _takePicture() async {
    //1. AMBIL IMAGE PHOTO DARI CAMERA
    //buat instan nya untuk inisialisasi
    final picker = ImagePicker();
    //dari instant ImagePicker kita perjelas parameternya
    final imageFile = await picker.getImage(
      //sourcenya bisa dari gallery dan camera
      source: ImageSource.camera,
      maxWidth: 600,
    );

    //jika tidak jadi take picture dari camera maka kembalikan tanpa nilai kembalian
    //untuk menghindari error tidak ada image yg mengubah state
    if (imageFile == null) {
      return;
    }

    //2. IMAGE PHOTO YANG DIAMBIL, MASUKKAN DALAM FOLDER
    setState(() {
      //imageFile itu adalah bertype PickedFile, karenanya harus di konver ke tipe File (convert pickerFile to Regular File)
      //remember : ini baru disimpan di memory
      _storedImage = File(imageFile.path);
    });

    //karenanya baru di memory simpannya, maka kita perlu pindahkan ke media penyimpanan, disini guna nya path_provider dan path
    //a. define application directory nya
    final appDir = await syspaths.getApplicationDocumentsDirectory();

    //b. basename get filename
    final fileName = path.basename(imageFile.path);
    //imageFile.copy()
    //c. simpan file temporer itu ke direktory yg ditentukan di atas
    //final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');

    //widget adalah properti global di State object yang dapat akses ke Kelas Widget nya (yaitu dlm hal ini ImageInput)
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No image taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
