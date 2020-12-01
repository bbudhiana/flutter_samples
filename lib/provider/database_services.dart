import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class DatabaseServices {
  //ini adalah set pertama kali, merupakan pointer ke collection di firestore
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  //create / update data
  static Future<void> createOrUpdateProduct(String id,
      {String name, int price}) async {
    await productCollection.doc(id).set({
      'nama': name,
      'harga': price,
    });
  }

  //ambil data
  static Future<DocumentSnapshot> getProduct(String id) async {
    return await productCollection.doc(id).get();
  }

  //delete product
  static Future<void> deleteProduct(String id) async {
    await productCollection.doc(id).delete();
  }

  //return nya adalah String, yaitu letak image nya
  static Future<String> uploadImage(File imageFile) async {
    //imageFile.path : alamat image kita di handphone secara penuh, termasuk folder
    //base name : kita hanya ambil file nya saja, misal sesuatu.png / sesuatu.jpg
    String fileName = basename(imageFile.path);

    //reference untuk file firebase storage nya untuk si fileName
    //StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    //Create a Reference to the file
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);

    //Perintah untuk upload
    //StorageUploadTask task = ref.putFile(imageFile);
    firebase_storage.Task task = ref.putFile(imageFile);

    /* final StreamSubscription<StorageTaskEvent> streamSubscription =
        task.events.listen((event) {
      // You can use this to notify yourself or your user in any kind of way.
      // For example: you could use the uploadTask.events stream in a StreamBuilder instead
      // to show your user what the current status is. In that case, you would not need to cancel any
      // subscription as StreamBuilder handles this automatically.

      // Here, every StorageTaskEvent concerning the upload is printed to the logs.
      print('EVENT ${event.type}');
    }); */

    //ambil snapshot nya untuk cek apakah sudah selesai atau belum upload file nya, yg akan diberikan jika task selesai/onComplete
    //StorageTaskSnapshot snapshot = await task.onComplete;
    firebase_storage.TaskSnapshot snapshot =
        await task.whenComplete(() => null);

    //Snapshot ini akan digunakan untuk mengambil download url dari file yg sudah di upload
    String urlImageFile = await snapshot.ref.getDownloadURL();

    // Cancel your subscription when done.
    //streamSubscription.cancel();

    return urlImageFile;
  }
}
