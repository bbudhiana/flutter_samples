part of 'countercubit_cubit.dart';

@immutable
abstract class CountercubitState {}

class CountercubitInitial extends CountercubitState {}

class CountercubitStateFilled extends CountercubitState {
  final int value;
  CountercubitStateFilled(this.value);
}
