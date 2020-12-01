import 'package:flutter/foundation.dart';
//dibutuhkan untuk ChangeNotifier

//dibuat ChangeNotifier, jika disini berubah maka akan didengar
class UiSet with ChangeNotifier {
  //nilai inisialisasi nya
  static double _fontsize = 0.5;

  set fontSize(newValue) {
    _fontsize = newValue;

    //trigger perubahan, kasih tahu listener bahwa ada perubahan
    notifyListeners();
  }

  //Untuk Text nya di state_management_screen / ui.fontSize
  double get fontSize => _fontsize * 30;
  //Untuk Slider nya di state_management_setting /  ui.sliderFontSize
  double get sliderFontSize => _fontsize;
}
