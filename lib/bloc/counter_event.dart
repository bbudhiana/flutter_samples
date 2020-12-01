part of 'counter_bloc_5.dart';

@immutable
abstract class CounterEvent {}

class CounterBlocIncrement extends CounterEvent {
  final int value;

  CounterBlocIncrement(this.value);
}
