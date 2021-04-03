import 'dart:convert';

import './flutter_samples_params.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    //will returns the map as an image
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  //https://developers.google.com/maps/documentation/geocoding/overview?authuser=1#reverse-restricted
  static Future<String> getPlaceAddress(double lat, double lng) async {
    //final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&location_type=ROOFTOP&result_type=street_address&key=$GOOGLE_API_KEY';

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&location_type=ROOFTOP&result_type=street_address&key=$GOOGLE_API_KEY');

    final response = await http.get(url);

    //results bisa lebih dari satu, karenanya ambil saja yg pertama
    //sample : "formatted_address" : "277 Bedford Avenue, Brooklyn, NY 11211, USA",
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
