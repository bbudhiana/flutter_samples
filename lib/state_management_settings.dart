import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/uiset.dart';

class StateManagementSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var ui = Provider.of<UiSet>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('settings for state'),
      ),
      body: Column(
        children: <Widget>[
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
