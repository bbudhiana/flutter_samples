import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './provider/color_bloc_flutter.dart';

//BLOC ini menggunakan package flutter_bloc, bukan lagi hanya pakai STREAMCONTROLLER dan STREAMBUILDER
class BlocTwoScreen extends StatelessWidget {
  static const routeName = '/bloc-two-screen';

  @override
  Widget build(BuildContext context) {
    //untuk mengambil provider di root nya
    //TIDAK PERLU ADA DISPOSE LAGI KARENA SUDAH DI TANGANI BLOCPROVIDER
    //KARENA ITU WIDGET TIDAK PERLU STATEFULL LAGI
    //ColorBlocFlutter bloc = BlocProvider.of<ColorBlocFlutter>(context); //lama
    //ColorBlocFlutter bloc = context.bloc<ColorBlocFlutter>();
    ColorBlocFlutter bloc = context.read<ColorBlocFlutter>();

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'btnBloc2_1',
            backgroundColor: Colors.amber,
            onPressed: () {
              //TRIGGER PERUBAHAN ColorBlocFlutter disini
              bloc.add(ColorEvent.to_ember);
            },
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'btnBloc2_2',
            backgroundColor: Colors.lightBlue,
            onPressed: () {
              //TRIGGER PERUBAHAN ColorBlocFlutter disini
              bloc.add(ColorEvent.to_light_blue);
            },
          )
        ],
      ),
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            'BLoC Sample Part 2 - with library and Hydrated',
            softWrap: true,
          ),
        ),
      ),
      body: Center(
        //DISINI DITANGKAP PERUBAHAN OLEH BlocBuilder DAN HASIL STREAM DI MASUKKAN KE sekarangColor
        //Kalo Change Notifier Provider sama dengan Consumer
        //BlocBuilder<BlocA, BlocAState>
        child: BlocBuilder<ColorBlocFlutter, Color>(
          builder: (context, sekarangColor) => AnimatedContainer(
            duration: Duration(microseconds: 500),
            width: 100,
            height: 100,
            color: sekarangColor,
          ),
        ),
      ),
    );
  }
}
