import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/routing.dart';

class MapHereScreen extends StatefulWidget {
  static const routeName = '/map-here-screen';

  @override
  _MapHereScreenState createState() => _MapHereScreenState();
}

class _MapHereScreenState extends State<MapHereScreen> {
  HereMapController _controller;
  MapPolyline _mapPolyline;

  //untuk simpan coordinates tempat wisata di jakarta (misal)
  List<GeoCoordinates> places;

  //untuk simpan marker tempat-tempat wisata itu
  List<MapMarker> markers;

  //tempat awal perhitungan
  GeoCoordinates initialLocation = GeoCoordinates(-6.2131111, 106.6146304);

  //JANGAN LUPA KETIKA APLIKASI TDK LAGI DIPAKAI AGAR DISPOSE CONTROLLER NYA
  @override
  void dispose() {
    //'?' artinya jika controller nya TIDAK NULL maka jalankan finalize() atau _controller.finalize()
    _controller?.finalize();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //UNTUK CONTOH, DIPASANG DATA-DATA WISATA
    places = [
      GeoCoordinates(-6.2968282, 106.803776), //ragunan
      GeoCoordinates(-6.3024459, 106.8929672), //tmii
      GeoCoordinates(-6.1253124, 106.831349), //Dufan
      GeoCoordinates(-6.1753924, 106.8249641), //Monas
    ];
    markers = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map menggunakan Here Map'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 500,
            child: HereMap(
              onMapCreated: onMapCreated,
            ),
          ),
          RaisedButton(
            child: Text('Clear Map'),
            onPressed: () {
              if (_mapPolyline != null) {
                _controller.mapScene.removeMapPolyline(_mapPolyline);
                //setelah diclear balikkan _mapPolyline jadi null lagi
                _mapPolyline = null;
              }
            },
          ),
          RaisedButton(
            child: Text('Find Nearest'),
            onPressed: () {
              //LAKUKAN URUTAN, DARI TERDEKAT ke TERJAUH
              markers.sort(
                (marker1, marker2) =>
                    initialLocation.distanceTo(marker1.coordinates).compareTo(
                          initialLocation.distanceTo(marker2.coordinates),
                        ),
              );
              //MAKA HASILNYA TERDEKAT ADALAH di markers[0], hapus dulu trus ganti path images nya
              _controller.mapScene.removeMapMarker(markers[0]);

              //insert lagi markers[0] dengan penanda nya winner.png
              drawMarker(_controller, 0, markers[0].coordinates,
                  path: 'assets/winner.png');
            },
          ),
        ],
      ),
    );
  }

  Future<MapMarker> drawMarker(HereMapController hereMapController,
      int drawOrder, GeoCoordinates geoCoordinates,
      {String path = 'assets/dotsmall.png'}) async {
    //ambil file dot nya
    ByteData fileData = await rootBundle.load(path);

    //8bit integer tanpa minus buat tampung file
    Uint8List pixelData = fileData.buffer.asUint8List();

    //ubah menjadi format image Map
    MapImage mapImage =
        MapImage.withPixelDataAndImageFormat(pixelData, ImageFormat.png);

    //jadikan mapImage menjadi marker di sebuah koordinat
    MapMarker mapMarker = MapMarker(geoCoordinates, mapImage);

    //perintahkan untuk di draw sesuai drawOrder yg diinput
    mapMarker.drawOrder = drawOrder;

    //tambahkan ke schema hereMapController drawOrder nya
    hereMapController.mapScene.addMapMarker(mapMarker);

    return mapMarker;
  }

  Future<void> drawRedDot(HereMapController hereMapController, int drawOrder,
      GeoCoordinates geoCoordinates) async {
    //ambil file dot nya
    ByteData fileData = await rootBundle.load('assets/dotsmall.png');

    //8bit integer tanpa minus buat tampung file
    Uint8List pixelData = fileData.buffer.asUint8List();

    //ubah menjadi format image Map
    MapImage mapImage =
        MapImage.withPixelDataAndImageFormat(pixelData, ImageFormat.png);

    //jadikan mapImage menjadi tipe map marker di sebuah koordinat
    MapMarker mapMarker = MapMarker(geoCoordinates, mapImage);

    //perintahkan untuk di draw sesuai drawOrder yg diinput
    mapMarker.drawOrder = drawOrder;

    //tambahkan ke schema hereMapController drawOrder nya
    hereMapController.mapScene.addMapMarker(mapMarker);
  }

  Future<void> drawPin(HereMapController hereMapController, int drawOrder,
      GeoCoordinates geoCoordinates) async {
    //ambil file dot nya
    ByteData fileData = await rootBundle.load('assets/pin.png');

    //8bit integer tanpa minus buat tampung file
    Uint8List pixelData = fileData.buffer.asUint8List();

    //ubah menjadi format image Map
    MapImage mapImage =
        MapImage.withPixelDataAndImageFormat(pixelData, ImageFormat.png);

    /*
      draw secara default dibuat di titik angker x,y = 0.5,0.5 atau di tengah
      angker memiliki titik 0,0 di ujung kiri atas - 1,1 ujung kanan bawah
      karenanya titik pin ini akan dipasang di 0.5, 1 agar tidak menghalangi 'dot'
      remember : angker itu relatif terhadap image yg di angker, 0.5,1 artinya posisi dimana image
                 di'cantol' dalam titik koordinat.
    */
    Anchor2D anchor2d = Anchor2D.withHorizontalAndVertical(0.5, 1);

    //jadikan mapImage menjadi marker di sebuah koordinat
    MapMarker mapMarker =
        MapMarker.withAnchor(geoCoordinates, mapImage, anchor2d);

    //perintahkan untuk di draw sesuai drawOrder yg diinput
    mapMarker.drawOrder = drawOrder;

    //tambahkan ke schema hereMapController drawOrder nya
    hereMapController.mapScene.addMapMarker(mapMarker);
  }

  Future<void> drawRoute(GeoCoordinates start, GeoCoordinates end,
      HereMapController hereMapController) async {
    //buat routing engine, yaitu menghitung route
    RoutingEngine routingEngine = RoutingEngine();

    ////buat way point
    Waypoint startWaypoint = Waypoint.withDefaults(start);
    Waypoint endWaypoint = Waypoint.withDefaults(end);
    List<Waypoint> wayPoints = [startWaypoint, endWaypoint];

    ////Hitung rute nya
    routingEngine.calculateCarRoute(wayPoints, CarOptions.withDefaults(),
        (routingError, routes) {
      if (routingError == null) {
        //jika tidak ada error maka ambil dari list routing yaitu yang PERTAMA
        var route = routes.first;

        ////buat garis-garis/polyline dari route yg telah dihitung
        GeoPolyline routeGeoPolyline = GeoPolyline(route.polyline);

        ////buat visual representasi dari polyline itu (warna, tebel, garis)
        double depth = 20;
        _mapPolyline = MapPolyline(routeGeoPolyline, depth, Colors.blue);

        ////Pasang di controller agar dapat digambar dalam peta
        hereMapController.mapScene.addMapPolyline(_mapPolyline);
      }
    });
  }

  void onMapCreated(HereMapController hereMapController) {
    //pasang controller disini untuk menggambar rute
    _controller = hereMapController;

    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (error) {
      if (error != null) {
        print('Error:' + error.toString());
        return;
      }
    });

    //draw order = 0 artinya pertama kali dibuat, order(urutan pembuatan image)
    //drawRedDot(hereMapController, 0, initialLocation);
    drawMarker(hereMapController, 0, initialLocation);
    drawPin(hereMapController, 1, initialLocation);
    drawRoute(GeoCoordinates(-6.2131111, 106.6146304),
        GeoCoordinates(-6.2090828, 106.6076681), hereMapController);

    //kita buat marker-markernya berdasarkan data places
    places.forEach((element) {
      drawMarker(hereMapController, 0, element).then(
        (marker) => markers.add(marker),
      );
    });

    //berapa meters di atas bumi
    double distanceToEarthInMeters = 125000;

    hereMapController.camera
        .lookAtPointWithDistance(initialLocation, distanceToEarthInMeters);
  }
}
