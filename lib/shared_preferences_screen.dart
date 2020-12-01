import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//FOR STORAGE IN USER DEVICE WITH SIMPLE DATA
//untuk menyimpan pemasangan di device user
//untuk menyimpan data-data simple di aplikasi kita, contoh setting warna, on-off, dll
//SharedPreferences in flutter uses NSUserDefaultson iOS and SharedPreferences on Android, providing a persistent store for simple data.

class SharedPreferencesScreen extends StatefulWidget {
  static const routeName = '/shared-preferences';
  @override
  _SharedPreferencesScreenState createState() =>
      _SharedPreferencesScreenState();
}

class _SharedPreferencesScreenState extends State<SharedPreferencesScreen> {
  TextEditingController controller = TextEditingController(text: 'No Name');
  bool isOn = false;

  //karena menggunakan shared preferences maka menggunakan method async
  void saveData() async {
    //FIRST : Get instant SharedPreferences
    //ambil instant dari shared preference nya
    SharedPreferences pref = await SharedPreferences.getInstance();

    //SECOND : Save into type you want
    //save yg ada di textfield dan switch di instant sharedpreferences
    pref.setString("name", controller.text);
    pref.setBool("ison", isOn);
  }

  //GET VALUE FROM SharedPreferences
  //Untuk load data nya, untuk ambil nama maka keluarannya adalah String dan merupakan tipe Future
  Future<String> getName() async {
    //buat instannya
    SharedPreferences pref = await SharedPreferences.getInstance();

    //kembalikan nilainya, jika tidak null maka pake getString("name") kalo null maka "No Data"
    return pref.getString("name") ?? "No Data";
  }

  //GET VALUE FROM SharedPreferences
  //Untuk load data switch
  Future<bool> getOn() async {
    //buat instannya
    SharedPreferences pref = await SharedPreferences.getInstance();

    //kembalikan nilainya, jika tidak null maka pake yg disimpan, jika null return false
    return pref.getBool("ison") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences Sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextField(
              controller: controller,
            ),
            Switch(
              value: isOn,
              onChanged: (newValue) {
                setState(() {
                  isOn = newValue;
                });
              },
            ),
            RaisedButton(
              child: Text("save"),
              onPressed: () {
                saveData();
              },
            ),
            RaisedButton(
              child: Text("load"),
              onPressed: () {
                getName().then((value) {
                  controller.text = value;
                  setState(() {});
                });
                getOn().then((value) {
                  isOn = value;
                  setState(() {});
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
