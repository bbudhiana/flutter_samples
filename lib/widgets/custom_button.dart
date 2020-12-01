import 'package:flutter/material.dart';
import 'package:division/division.dart';
import '../styles/custom_styles.dart';

class CustomButton extends StatefulWidget {
  final ParentStyle buttonStyle;

  CustomButton(this.buttonStyle);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isTapDown = false;

  @override
  Widget build(BuildContext context) {
    //Parent widget ini milik Division
    //Widget untuk style dari widget yang dibungkusnya, seperti mirip css
    return Parent(
      gesture: Gestures()
        ..onTapDown((details) {
          setState(() {
            isTapDown = true;
          });
        })
        ..onTapUp((details) {
          setState(() {
            isTapDown = false;
          });
        })
        ..onTapCancel(() {
          setState(() {
            isTapDown = false;
          });
        }),
      /* style: ParentStyle(angleFormat: AngleFormat.degree)
        ..background.color(Colors.lightBlue[300])
        ..borderRadius(all: 60)
        ..border(all: 3, color: Colors.lightBlue[900])
        ..elevation(5)
        ..padding(left: 20, right: 20, top: 15, bottom: 15)
        //aktifkan dulu angleFormat: AngleFormat.degree, kemudian bisa setting rotate
        ..rotate(-5), */
      style: widget.buttonStyle.clone()
        //jika diteken lama maka membesar sebesar 1.1 dan elevation 0 (tidak berbayang)
        ..scale((isTapDown) ? 1.1 : 1)
        ..elevation((isTapDown) ? 0 : 5),
      child: Container(
        //DIVISION juga punya Txt untuk Text, Style nya pake TxtStyle
        child: Txt(
          "Division",
          /* style: TxtStyle()
            ..fontSize(30)
            ..fontFamily("Lato")
            ..bold()
            ..textColor(Colors.white), */
          style: CustomStyles.txtStyle,
        ),
      ),
    );
  }
}
