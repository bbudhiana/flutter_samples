import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_samples/bloc/counterthree_bloc.dart';

import 'widgets/number_card.dart';

class BlocThreeScreen extends StatelessWidget {
  static const routeName = '/bloc-three-screen';

  /*
    source : https://pub.dev/packages/provider
      The easiest way to read a value is by using the extension methods on [BuildContext]:

    context.watch<T>(), which makes the widget listen to changes on T
    context.read<T>(), which returns T without listening to it
    context.select<T, R>(R cb(T value)), which allows a widget to listen to only a small part of T.

    It's worth noting that context.read<T>() won't make widget rebuild when the value changes 
    and cannot be called inside StatelessWidget.build/State.build. 
    On the other hand, it can be freely called outside of these methods.

    */
  //ProductBloc bloc = context.bloc<ProductBloc>();
  //ProductBloc bloc = context.read<ProductBloc>();
  //ProductBloc bloc = context.watch<ProductBloc>();

  @override
  Widget build(BuildContext context) {
    //watch berfungsi baca dan pantau maka jika ada perubahan akan berubah
    CounterthreeState counterthreeState =
        context.watch<CounterthreeBloc>().state;

    //select fungsi sama denga wathc, selain baca maka juga pantau, tapi dia bisa lebih spesifik yg ingin dipantau perubahannya
    //R select<T, R>(R Function(T) selector) , T (type bloc) R (type data yg dipantau)
    //yang diingin di pantau adalah value milik state yang return nya adalah int
    int number = context.select<CounterthreeBloc, int>((counterthreeBloc) =>
        (counterthreeBloc.state is CounterthreeValue)
            ? (counterthreeBloc.state as CounterthreeValue).value
            : null);

    return Scaffold(
        appBar: AppBar(
          title: Text('Bloc Three - Number Card'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<CounterthreeBloc, CounterthreeState>(
                  builder: (_, state) => NumberCard(
                    title: "Bloc\nBuilder",
                    number: (state is CounterthreeValue) ? state.value : null,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                NumberCard(
                  title: "Watch",
                  number: (counterthreeState is CounterthreeValue)
                      ? counterthreeState.value
                      : null,
                ),
                SizedBox(
                  width: 40,
                ),
                NumberCard(
                  title: "Select",
                  number: number,
                ),
              ],
            ),
            SizedBox(
              width: 40,
            ),
            RaisedButton(
              child: Text(
                'Increment',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              shape: StadiumBorder(),
              color: Colors.green[800],
              onPressed: () {
                //hanya baca apakah ada perubahan, tapi tidak pantau perubahan
                context.read<CounterthreeBloc>().add(Increment());
              },
            )
          ],
        ));
  }
}
