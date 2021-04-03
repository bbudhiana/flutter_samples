import 'dart:async';

import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  static const routeName = '/timer-screen';

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  bool isStop = true;
  bool isBlack = true;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Timer flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                counter.toString(),
                style: TextStyle(
                    color: (isBlack) ? Colors.black : Colors.redAccent,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text('start timer!'),
                onPressed: () {
                  //inisialisasi
                  isStop = false;
                  counter = 0;
                  //setiap satu detik jalankan method nya, jadi setiap 1 detik buat Timer dan eksekusi method nya
                  Timer.periodic(Duration(seconds: 1), (timer) {
                    //untuk memberhentikan timer, gunakan cancel
                    if (isStop) timer.cancel();
                    setState(() {
                      counter++;
                    });
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text('stop timer!'),
                onPressed: () {
                  isStop = true;
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text('ubah warna langsung!'),
                onPressed: () {
                  Timer.run(() {
                    setState(() {
                      isBlack = !isBlack;
                    });
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text('ubah warna 5 detik kemudian!'),
                onPressed: () {
                  Timer(Duration(seconds: 5), () {
                    setState(() {
                      isBlack = !isBlack;
                    });
                  });
                },
              )
            ],
          ),
        ));
  }
}
