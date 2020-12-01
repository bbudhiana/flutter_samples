import 'package:flutter/foundation.dart';

class TimeState with ChangeNotifier {
  int _time = 15;

  int get time => _time;

  set time(int newValue) {
    _time = newValue;
    notifyListeners();
  }
}
