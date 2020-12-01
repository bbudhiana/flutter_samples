import 'package:flutter/material.dart';

class ApplicationLifecycleStateScreen extends StatefulWidget {
  static const routeName = "/application-lifecycle";

  @override
  _ApplicationLifecycleStateScreenState createState() =>
      _ApplicationLifecycleStateScreenState();
}

//Untuk analisa lifecycle kita gunakan sebuah observer WidgetsBindingObserver
//
class _ApplicationLifecycleStateScreenState
    extends State<ApplicationLifecycleStateScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    //SET this, INI ADALAH KELAS MENGOBSERVASI LIVECYCLE
    WidgetsBinding.instance.addObserver(this);
  }

  //disponse
  @override
  void dispose() {
    super.dispose();
    //JIKA OBSERVER NYA SUDAH SELESAI/TIDAK DIGUNAKAN MAKA DIREMOVE KETIKA APLIKASI TUTUP
    WidgetsBinding.instance.removeObserver(this);
  }

  //SETIAP ADA PERUBAHAN DARI STATE MILIK APLIKASI AKAN EKSEKUSI METHOD didChangeAppLifecycleState
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    //state dimana aplikasi masih ada di screen tapi bukan yang tampil saat ini,
    //misal ketika ada telpon maka aplikasi jadi terhalang, atau lagi pilih2 aplikasi (tombol III di hp)
    if (state == AppLifecycleState.inactive) {
      print("===> INACTIVE <===");
    }

    //state jika aplikasi tetap berjalan tapi sedang tidak ada di layar,
    //misal ketika klik tombol kotak
    if (state == AppLifecycleState.paused) {
      print("===> PAUSED <===");
    }

    //state ketika dari posisi state paused menjadi tampil kembali
    if (state == AppLifecycleState.resumed) {
      print("===> RESUMED <===");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application Lifecycle State Flutter"),
      ),
      body: Container(),
    );
  }
}
