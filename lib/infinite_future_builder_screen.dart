import 'package:flutter/material.dart';
import 'package:flutter_samples/screens/infinite_future_builder.dart';

class InfiniteFutureBuilderScreen extends StatelessWidget {
  static const routeName = '/infinite-future-builder';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Loading with Future Builder'),
      ),
      body: InfiniteFutureBuilder(),
    );
  }
}
