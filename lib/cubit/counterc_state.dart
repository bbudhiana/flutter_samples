part of 'counterc_cubit.dart';

@immutable
abstract class CountercState {}

//class CountercInitial extends CountercState {}

class CountercInitial extends CountercState {
  final int _number;
  CountercInitial({int number}) : _number = number ?? 0;

  int get number => _number;
}

/* class InitializedCounterc extends CountercState {
  final int number;
  InitializedCounterc(this.number);
} */
