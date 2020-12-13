import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: -6.2130494, longitude: 106.6147353),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                icon: Icon(Icons.check),
                //biar aman maka proses onPressed akan dilakukan jika user sudah _pickedLocation nya
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        //kembali ke screen sebelumnya dengan membawa nilai balik berupa lokasi yang di pilih
                        Navigator.of(context).pop(_pickedLocation);
                      }),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        //jika dapat di 'Select' maka gunakan funtion _selectLocation, selain itu kasih null saja
        //isSelecting, jika false maka untuk tampilan view saja (setiap klik tidak berubah),
        //isSelecting, jika true maka untuk tampilan create dan update (perubahan di akomodir _selectLocation)
        onTap: widget.isSelecting ? _selectLocation : null,
        //tipe data markers adalah Set {} , berisi hanya value seperti halnya List, bukan key-value seperti halnya Map
        //hal spesial Set adalah setiap values nya di pastikan unik, jika kita tambahkan sesuatu yg sudah ada di set maka tidak akan ditambahkan
        markers: (_pickedLocation == null && widget.isSelecting)
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  //posisi adalah titik yg di pilih (picked) atau dari inisialisasi
                  position: _pickedLocation ??
                      LatLng(
                        widget.initialLocation.latitude,
                        widget.initialLocation.longitude,
                      ),
                )
              },
      ),
    );
  }
}
