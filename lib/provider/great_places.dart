import 'dart:io';

import 'package:flutter/foundation.dart';
import '../model/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    //GET address string nya
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);

    //JADIKAN PlaceLocation yg parametersnya terdiri dari 3 : latitude, longitude, dan address
    final updateLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);

    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updateLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    //setelah di memory di rebuild maka insert ke DB nya
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.latitude,
        'loc_lng': newPlace.location.longitude,
        'address': newPlace.location.address
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    //ambil datanya dari db sqlite
    final dataList = await DBHelper.getData('user_places');
    print(dataList);

    //sesuaikan / Cast tipe datanya menjadi miliknya _items yaitu List<Place>
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }
}
