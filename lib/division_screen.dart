import 'package:division/division.dart';
import 'package:flutter/material.dart';

import 'styles/custom_styles.dart';
import 'widgets/custom_button.dart';

class DivisionScreen extends StatelessWidget {
  static const routeName = "/division-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text('Division - Custom Widget'),
          title: Txt(
            'Division - Custom Widget',
            style: CustomStyles.txtStyle.clone()..fontSize(20),
          ),
          backgroundColor: Colors.red[900],
        ),
        backgroundColor: Colors.grey[800],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(CustomStyles.buttonStyle),
              SizedBox(
                height: 20,
              ),
              //Kalo mo buat baru, tinggal di clone() saja dan ubah style nya
              CustomButton(
                CustomStyles.buttonStyle.clone()
                  ..background.color(Colors.green[300])
                  ..border(all: 3, color: Colors.green[900]),
              ),
            ],
          ),
        ));
  }
}
