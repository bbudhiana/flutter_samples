import 'package:flutter/material.dart';

class ApplicationLifecycleStateScreen extends StatefulWidget {
  static const routeName = "/application-lifecycle";

  @override
  _ApplicationLifecycleStateScreenState createState() =>
      _ApplicationLifecycleStateScreenState();
}

//Untuk analisa lifecycle kita gunakan sebuah observer WidgetsBindingObserver
class _ApplicationLifecycleStateScreenState
    extends State<ApplicationLifecycleStateScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    //SET this, THIS IS FOR LIVECYCLE OBSERVATION
    WidgetsBinding.instance.addObserver(this);
  }

  //disponse
  @override
  void dispose() {
    super.dispose();
    //IF OBSERVER NOT USED ANYMORE THEN REMOVE WHEN YOU CLOSE APPLICATION
    WidgetsBinding.instance.removeObserver(this);
  }

  //SETIAP ADA PERUBAHAN DARI STATE MILIK APLIKASI AKAN EKSEKUSI METHOD didChangeAppLifecycleState
  //EVERYTIME THERE ARE ANY CHANGE FROM STATE, THEN WILL EXECUTED diChangeAppLifeCycleState
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    //state dimana aplikasi masih ada di screen tapi bukan yang tampil saat ini,
    //STATE WHEN APPLICATION ON SCREEN, BUT NOT SHOW BECAUSE COVER BY OTHER APPS
    //misal ketika ada telpon maka aplikasi jadi terhalang, atau lagi pilih2 aplikasi (tombol |||di hp)
    if (state == AppLifecycleState.inactive) {
      print("===> INACTIVE <===");
    }

    //state jika aplikasi tetap berjalan tapi sedang tidak ada di layar,
    //STATE WHEN APPLICATION ON RUNNING, BUT NOT ON SCREEN
    //misal ketika klik tombol kotak
    if (state == AppLifecycleState.paused) {
      print("===> PAUSED <===");
    }

    //state ketika dari posisi state paused menjadi tampil kembali
    //STATE WHEN APPLICATION FROM PAUSED STATE TO RUN MODE
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
