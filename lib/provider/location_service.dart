import 'dart:async';

import 'package:flutter_samples/provider/user_location.dart';
import 'package:location/location.dart';

//Kelas ini untuk menggunakan fungsi-fungsi di paket location
class LocationService {
  //menginisialisasi paket location dan mulai listen perubahan-perubahan lokasi
  Location location = Location();

  //Yang jadi 'aliran data' / StreamController adalah UserLocation yang menyimpan longitude dan latitude
  //menggunakan 'aliran data' karena kita ingin dapat perubahannya, maka gunakan STREAM
  StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>();

  //untuk ambil/get 'aliran data' stream UserLocation
  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    //minta permisi dulu, return nya adalah permissionStatus
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        //jika sudah ada ijin gunakan location maka location bisa gunakan method onLocationChanged
        //method ini untuk mendeteksi perubahan hasil dari 'listen', hasil listen adalah data lokasi (locationData)
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            //kemudian hasil data locationData diinput dalam Stream UserLocation di variable _locationStreamController
            //agar bisa dialirkan
            _locationStreamController.add(
              UserLocation(
                  latitude: locationData.latitude,
                  longitude: locationData.longitude),
            );
          }
        });
      }
    });
  }

  //JANGAN LUPA LAKUKAN DISPOSE INI KARENA ADANYA CONTROLLER YG DIGUNAKAN AGAR TIDAK MEMORY LEAK
  void dispose() => _locationStreamController.close();
}
