import 'package:flutter/material.dart';
import './widgets/switch_daynight.dart';

class RiveFlutterScreen extends StatelessWidget {
  static const routeName = "/rive-flutter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rive and Flutter"),
      ),
      body: Center(
        child: GestureDetector(
          child: SwitchDaynight(),
        ),
      ),
    );
  }
}
