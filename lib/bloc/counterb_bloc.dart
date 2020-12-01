import 'dart:async';

import 'package:meta/meta.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'counterb_event.dart';
part 'counterb_state.dart';

class CounterbBloc extends ReplayBloc<CounterbEvent, CounterbState> {
  CounterbBloc() : super(CounterbInitial());

  @override
  Stream<CounterbState> mapEventToState(
    CounterbEvent event,
  ) async* {
    if (event is Incement) {
      if (state is CounterbInitial) {
        yield InitializedCounterb(0);
      } else {
        yield InitializedCounterb((state as InitializedCounterb).number + 1);
      }
    }
  }
}
