import 'package:meta/meta.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'counterc_state.dart';

class CountercCubit extends ReplayCubit<CountercState> {
  CountercCubit() : super(CountercInitial());

  void increment() {
    //jika state sudah ada angkanya maka lakukan update InitializedCounterc nya
    //state yang belum ada angkat/value nya itu CountercInitial
    /* if (state is InitializedCounterc) {
      emit(InitializedCounterc((state as InitializedCounterc).number + 1));
    } else {
      emit(InitializedCounterc(0));
    } */
    emit(CountercInitial(number: (state as CountercInitial).number + 1));
    /* if (CountercInitial().number != 0) {
      emit(CountercInitial(number: CountercInitial().number + 1));
    } else {
      emit(CountercInitial());
    } */
  }
}
