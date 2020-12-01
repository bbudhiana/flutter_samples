import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_restful_sample/ui/draft_page.dart';
import 'package:flutter_http_restful_sample/ui/second_page.dart';

import './bloc/color_bloc.dart';
import './bloc/counter_bloc.dart';

class MultiblocScreen extends StatelessWidget {
  static const routeName = '/multibloc_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorBloc, Color>(
      builder: (context, color) => DraftPage(
        backgroundColor: color,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<CounterBloc, int>(
                builder: (context, number) => Text(
                  number.toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondPage()));
                },
                child: Text(
                  'Click to change',
                  style: TextStyle(color: Colors.white),
                ),
                color: color,
                shape: StadiumBorder(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
