part of 'counterthree_bloc.dart';

abstract class CounterthreeEvent extends Equatable {
  const CounterthreeEvent();

  @override
  List<Object> get props => [];
}

class Increment extends CounterthreeEvent {}
