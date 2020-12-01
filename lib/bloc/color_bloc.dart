import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum ColorEvent { toPink, toEmber, toPurple }

class ColorBloc extends Bloc<ColorEvent, Color> {
  ColorBloc() : super(initialState);

  static Color get initialState => Colors.pink;

  @override
  Stream<Color> mapEventToState(ColorEvent event) async* {
    yield (event == ColorEvent.toPink)
        ? Colors.pink
        : (event == ColorEvent.toEmber) ? Colors.amber : Colors.purple;
  }
}
