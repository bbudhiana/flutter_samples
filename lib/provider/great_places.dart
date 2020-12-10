import 'dart:io';

import 'package:flutter/foundation.dart';
import '../model/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    //setelah di memory di rebuild maka insert ke DB nya
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    //ambil datanya dari db sqlite
    final dataList = await DBHelper.getData('user_places');

    //sesuaikan / Cast tipe datanya menjadi miliknya _items yaitu List<Place>
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: null,
          ),
        )
        .toList();

    notifyListeners();
  }
}
