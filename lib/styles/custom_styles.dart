import 'package:division/division.dart';
import 'package:flutter/material.dart';

abstract class CustomStyles {
  static ParentStyle buttonStyle = ParentStyle(angleFormat: AngleFormat.degree)
    ..background.color(Colors.lightBlue[300])
    ..borderRadius(all: 60)
    ..border(all: 3, color: Colors.lightBlue[900])
    ..elevation(5)
    ..padding(left: 20, right: 20, top: 15, bottom: 15)
    //aktifkan dulu angleFormat: AngleFormat.degree, kemudian bisa setting rotate
    ..rotate(-5)
    //warnanya bergerak di button ketika di TapDown
    ..ripple(true, splashColor: Colors.yellow);

  static TxtStyle txtStyle = TxtStyle()
    ..fontSize(30)
    ..fontFamily("Lato")
    ..bold()
    ..textColor(Colors.white);
}
