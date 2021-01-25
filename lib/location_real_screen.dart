import 'package:flutter/material.dart';
import 'package:flutter_samples/provider/location_service.dart';

import 'provider/user_location.dart';

class LocationRealScreen extends StatefulWidget {
  static const routeName = '/location-real-screen';

  @override
  _LocationRealScreenState createState() => _LocationRealScreenState();
}

class _LocationRealScreenState extends State<LocationRealScreen> {
  LocationService locationService = LocationService();

  //kalo gunakan stream listener, buat dulu tampungan datanya
  double latitude = 0;
  double longitude = 0;

  //kalo gunakan stream listener, maka perlu initState
  @override
  void initState() {
    //buat listenernya saat masuk halaman ini yaitu ketika initState
    locationService.locationStream.listen((userLocation) {
      setState(() {
        latitude = userLocation.latitude;
        longitude = userLocation.longitude;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Real Update Location of User'),
      ),

      ////MENGGUNAKAN STREAM LISTENER
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Latitude:'),
            Text(
              '${latitude}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Longitude'),
            Text(
              '${longitude}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),

      ////MENGGUNAKAN STREAMBUILDER
      /* body: StreamBuilder<UserLocation>(
        stream: locationService.locationStream,
        builder: (_, snapshot) => (snapshot.hasData)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Latitude:'),
                    Text(
                      '${snapshot.data.latitude}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Longitude'),
                    Text(
                      '${snapshot.data.longitude}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            : SizedBox(),
      ), */
    );
  }
}
