import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/uiset.dart';

//HOW TO USE PROVIDER PACKAGE
//THE ChangeNotifier load in main.dart
//ChangeNotifierProvider<UiSet>(create: (_) => UiSet()),

class StateManagementSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var ui = Provider.of<UiSet>(context); //can use this, but widget will build from here
    return Scaffold(
      appBar: AppBar(
        title: Text('settings for state'),
      ),
      body: Column(
        children: <Widget>[
          //widget only rebuild from here where you define change provider with consumer
          //karena perubahan disini, maka disini saja rebuild nya
          Consumer<UiSet>(
              builder: (context, ui, _) => ListTile(
                    title: Text('${ui.fontSize.toInt()}'),
                    subtitle: Slider(
                      min: 0.5,
                      value: ui.sliderFontSize,
                      //trigger perubahan uiset.dart oleh event onChanged
                      onChanged: (newValue) {
                        ui.fontSize = newValue;
                      },
                    ),
                  ))

          /* ListTile(
            title: Text('${ui.fontSize.toInt()}'),
            subtitle: Slider(
              min: 0.5,
              value: ui.sliderFontSize,
              onChanged: (newValue) {
                ui.fontSize = newValue;
              },
            ),
          ) */
        ],
      ),
    );
  }
}
