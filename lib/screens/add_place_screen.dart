import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';
import '../provider/great_places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routename = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  //untuk nampung hasil olahan dari ImageInput, hasil ImageInput dimasukkan dalam _pickedImage
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    //save tapi tidak perlu rebuild widget nya
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
    //kembali ke awal page
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //secara baris di 'stretch' sampai maksimal
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //expanded itu mengambil sisa size screen yg ada (screenheight - height dari RaisedButton)
          Expanded(
            //setelah di-expanded (ambil sisa screen), kemudian screen yg terambil di scrollview kan
            child: SingleChildScrollView(
              //kemudian ditambahkan padding agar ada 'ruang' sisi sisi nya
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _savePlace,
            elevation: 0,
            //materialTapTargetSize = membuat button penuh, shrinkWrap menambah area tap
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.yellow[400],
          )
        ],
      ),
    );
  }
}
