import 'package:flutter/material.dart';
import 'package:flutter_samples/screens/infinite_steam_builder.dart';

class InfiniteStreamBuilderScreen extends StatelessWidget {
  static const routeName = '/infinite-stream-builder';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Loading with Stream Builder'),
      ),
      body: InfiniteStreamBuilder(),
    );
  }
}
