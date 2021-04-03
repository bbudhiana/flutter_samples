import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double lat, double lng) {
    //generate image map berdasarkan latitude dan longitude
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);

    //print('latitude : ${lat} and longitude :${lng}');

    //Rebuild setelah terambil lokasi terkini
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<bool> _checkServicePermission() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    bool _checkIsOk;

    //check service map
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        _checkIsOk = false;
      }
      _checkIsOk = true;
    } else {
      _checkIsOk = true;
    }

    //check permission map
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        _checkIsOk = false;
      }
      _checkIsOk = true;
    } else {
      _checkIsOk = true;
    }
    //return _serviceEnabled && (_permissionGranted == PermissionStatus.granted);
    return _checkIsOk;
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      //cek service map enable or not dan permission enable or not
      bool hasServicePermission = await _checkServicePermission();
      print(hasServicePermission);

      //jika service dan atau permission bermasalah maka kembalikan nothing saja
      if (!hasServicePermission) {
        return;
      }

      Location location = new Location();
      location.changeSettings(accuracy: LocationAccuracy.high);

      //ambil lokasi saat ini dari user yg pegang perangkat
      final locData = await location.getLocation();

      //Rebuild setelah terambil lokasi terkini
      _showPreview(locData.latitude, locData.longitude);

      //eksekusi function dari screen sebelumnya
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    //mengambil _pickedLocation dari map_screen.dart
    //final LatLng selectedLocation = await Navigator.of(context).push(
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    //jika user membatalkan pemilihan lokasi maka kembalikan null saja
    if (selectedLocation == null) {
      print('gak ada');
      return;
    }
    //jika user sudah memilih lokasi maka lakukan di bawah ini
    print('ada!');
    print(selectedLocation.latitude);

    //Rebuild setelah terambil lokasi terkini
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);

    //jalankan fungsi ygn dikirimkan dari screen sebelumnya
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text('No location chosen', textAlign: TextAlign.center)
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on map'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
            /* FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ), */
            /* FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            ), */
          ],
        )
      ],
    );
  }
}
