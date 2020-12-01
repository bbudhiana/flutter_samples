import 'package:flutter/material.dart';
import './provider/color_bloc.dart';

/*
global kerjanya Bloc:
event -->  Bloc  -->  Application UI
1. click button untuk triger event
2. Bloc akan proses event dan mengubah state menjadi state baru (mapping state)
3. state baru itu yang dijadikan untuk mengubah UI
Dalam Bloc ada stream controller : component yg mengkontrol aliran data
stream terdiri 2 hal : sink (keran) dan stream (aliran data)
sink = input
stream = aliran
*/

class BlocOneScreen extends StatefulWidget {
  static const routeName = '/bloc-one-screen';

  @override
  _BlocOneScreenState createState() => _BlocOneScreenState();
}

class _BlocOneScreenState extends State<BlocOneScreen> {
  ColorBloc bloc = ColorBloc();

  //jika widget ditutup maka bersihkan juga stream nya
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'btnBloc1',
            backgroundColor: Colors.amber,
            onPressed: () {
              //tinggal hubungkan eventSink dengan variable yang dibutuhkan, yaitu ColorEvent
              bloc.eventSink.add(ColorEvent.to_ember);
            },
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'btnBloc2',
            backgroundColor: Colors.lightBlue,
            onPressed: () {
              bloc.eventSink.add(ColorEvent.to_light_blue);
            },
          )
        ],
      ),
      appBar: AppBar(
        title: Text('BLoC Sample Part 1 - tanpa library'),
      ),
      body: Center(
        //streambuilder berfungsi merebuild widget setiap kali dia mendapatkan update dari stream
        //DISINILAH PERUBAHAN ITU TERJADI AKIBAT ADANYA EVENT dan STREAM, yaitu menggunakan 'StreamBuilder'
        child: StreamBuilder(
          stream: bloc.stateStream,
          initialData: Colors.amber,
          //snapshot adalah data yg dikirimkan dari stream
          builder: (context, snapshot) {
            return AnimatedContainer(
              duration: Duration(
                milliseconds: 500,
              ),
              width: 100,
              height: 100,
              //output datanya berupa color, karena stream berupa color / Stream<Color>
              color: snapshot.data,
            );
          },
        ),
      ),
    );
  }
}
