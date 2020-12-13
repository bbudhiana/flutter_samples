import 'package:flutter/material.dart';
import './screens/places_list_screen.dart';

/*
    Image Picker Package: https://pub.dev/packages/image_picker

    Location Package: https://pub.dev/packages/location

    Path Provider Package: https://pub.dev/packages/path_provider

    Path Package: https://pub.dev/packages/path

    Google Maps Package: https://pub.dev/packages/google_maps_flutter

    SQFLite Package: https://pub.dev/packages/sqflite
*/

class GreatPlacesScreen extends StatelessWidget {
  static const routeName = "/great_places";

  @override
  Widget build(BuildContext context) {
    return PlacesListScreen();
  }
}
