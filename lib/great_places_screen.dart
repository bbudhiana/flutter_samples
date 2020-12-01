import 'package:flutter/material.dart';
import './screens/places_list_screen.dart';

class GreatPlacesScreen extends StatelessWidget {
  static const routeName = "/great_places";

  @override
  Widget build(BuildContext context) {
    return PlacesListScreen();
  }
}
