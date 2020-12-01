import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './state_management_settings.dart';
import './provider/uiset.dart';

//HOW TO USE PROVIDER PACKAGE
//THE ChangeNotifier load in main.dart
//ChangeNotifierProvider<UiSet>(create: (_) => UiSet()),

class StateManagementScreen extends StatelessWidget {
  static const routeName = '/state-management';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample Provider State Management'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StateManagementSettings(),
                ),
              );
            },
          ),
        ],
      ),
      body: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
      context.read<UiSet>()  === Provider.of<UiSet>(context, listen: false)
      context.watch<UiSet>()  ===   Provider.of<UiSet>(context)
    */
    //var ui = Provider.of<UiSet>(context);
    /* 
    //USING Provider.of or context.watch
    var ui = context.watch<UiSet>();
    return Center(
      child: Text(
        'Bana Budhiana Learn Flutter',
        style: TextStyle(fontSize: ui.fontSize),
      ),
    ); 
    
    */
    //USING CONSUMER
    return Center(
      child: Consumer<UiSet>(
        builder: (context, uiChange, _) => Text(
          'Bana Budhiana Learn Flutter',
          style: TextStyle(fontSize: uiChange.fontSize),
        ),
      ),
    );
  }
}
