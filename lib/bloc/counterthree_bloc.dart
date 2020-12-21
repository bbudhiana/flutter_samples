import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counterthree_event.dart';
part 'counterthree_state.dart';

class CounterthreeBloc extends Bloc<CounterthreeEvent, CounterthreeState> {
  CounterthreeBloc() : super(CounterthreeInitial());

  @override
  Stream<CounterthreeState> mapEventToState(
    CounterthreeEvent event,
  ) async* {
    if (event is Increment) {
      if (state is CounterthreeInitial) {
        yield CounterthreeValue(0);
      } else {
        yield CounterthreeValue((state as CounterthreeValue).value + 1);
      }
    }
  }
}
