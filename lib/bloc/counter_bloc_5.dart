import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc5 extends Bloc<CounterEvent, CounterState> {
  ///BLoC version 5
  CounterBloc5() : super(CounterInitial());

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is CounterBlocIncrement) {
      yield (state is CounterInitial)
          ? CounterBlocState(0)
          : CounterBlocState((state as CounterBlocState).value + event.value);
    }
  }

  ///=== old version ===
  ///CounterState get initialState => CounterInitial();

}
