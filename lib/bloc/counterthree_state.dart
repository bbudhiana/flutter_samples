part of 'counterthree_bloc.dart';

abstract class CounterthreeState extends Equatable {
  const CounterthreeState();

  @override
  List<Object> get props => [];
}

class CounterthreeInitial extends CounterthreeState {}

class CounterthreeValue extends CounterthreeState {
  final int value;

  CounterthreeValue(this.value);

  @override
  List<Object> get props => [value];
}
