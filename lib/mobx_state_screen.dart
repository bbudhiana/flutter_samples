import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import './mobx/counter.dart';

class MobxStateScreen extends StatelessWidget {
  static const routeName = "/mobx-screen";

  //pasang kelas Mobx nya dimana nilai counter yang berubah
  final CounterMobx counter = CounterMobx();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobx State Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SET bagian widget yang berubah state nya
            Observer(
              builder: (context) => Text(counter.value.toString(),
                  style: TextStyle(fontSize: 80)),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: "bawah_panah",
                  onPressed: () {
                    counter.decrement();
                  },
                  child: Icon(Icons.arrow_downward),
                ),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  heroTag: "atas_panah",
                  onPressed: () {
                    counter.increment();
                  },
                  child: Icon(Icons.arrow_upward),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
