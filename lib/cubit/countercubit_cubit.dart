//import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'countercubit_state.dart';

class CountercubitCubit extends Cubit<CountercubitState> {
  CountercubitCubit() : super(CountercubitInitial());

  void cubitIncrement(int value) {
    //mengeluarkan state = emit
    emit((state is CountercubitStateFilled)
        ? CountercubitStateFilled(
            (state as CountercubitStateFilled).value + value)
        : CountercubitStateFilled(0));
  }
}
