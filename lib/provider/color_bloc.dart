import 'dart:async';

import 'package:flutter/material.dart';

//daftarkan event-eventnya
enum ColorEvent { to_ember, to_light_blue }

//buat kelas Bloc nya
//INI ADALAH CONTOH PENGGUNAAN BLOC TANPA LIBRARY, HANYA GUNAKAN STREAMCONTROLLER dan STREAMSINK punya dart:async
class ColorBloc {
  //menyimpan state yaitu warna oleh variable _color
  //berupa private, artinya tidak bisa diakses langsung dari luar
  Color _color = Colors.amber;

  //EVENT - UNTUK MENERIMA INPUT
  //set stream controllernya, yaitu
  //1. streamcontroller untuk event color (event colornya)
  //input -> streamcontroller event -> mapEventToState Method -> streamcontroller state -> output

  //ColorEvent adalah nama eventnya atau yang akan ditrigger dengan suatu input misal click button
  StreamController<ColorEvent> _eventController =
      StreamController<ColorEvent>();
  //penampung input untuk dikirim ke method mapEventToState, dibuat public agar bisa diisi dari luar
  StreamSink<ColorEvent> get eventSink => _eventController.sink;

  //STATE - UNTUK DIKEMBALIKAN KE UI
  //2. streamcontroller untuk state color (perubahan color nya)
  //dibuat private karena adanya di dalam
  StreamController<Color> _stateController = StreamController<Color>();
  //penampung output
  StreamSink<Color> get _stateSink => _stateController.sink;

  //STREAM (ALIRAN DATA) - ini method get selangnya yang jadi output, dibuat public agar bisa diambil dari luar
  Stream<Color> get stateStream => _stateController.stream;

  //Disinilah kerja UTAMA BLOCK, MAPPING EVENT ke STATE
  //dibuat private karena ada di dalam stream
  void _mapEventToState(ColorEvent colorEvent) {
    if (colorEvent == ColorEvent.to_ember)
      _color = Colors.amber;
    else
      _color = Colors.lightBlue;
    //ketika colorEvent terjadi, maka _stateSink input value state _color
    //SINK adalah input, jadi dia selalu 'add', dan STREAM adalah output
    _stateSink.add(_color);
  }

  //DALAM CONSTRUCTOR DI INISIALISASIKAN EVENT KE MAPEVENTTOPSTATE nya
  //constructor ColorBloc stream dari event controller, masukkan mapEventToState functionnya
  //menghubungkan event ke state nya dengan melalui _mapEventToState
  ColorBloc() {
    //pasangkan stream event controller dengan mapeventtostate : input(event) --> _mapEventToState --> stream
    _eventController.stream.listen(_mapEventToState);
  }

  //tukang beres2 selang/stream, jika sudah selesai pake stream maka untuk membebaskan memory harus di dispose
  //jika tidak di hapus/diberesin maka memory akan menumpuk
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
