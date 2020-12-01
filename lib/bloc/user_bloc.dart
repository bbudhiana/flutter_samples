import 'package:bloc/bloc.dart';
import 'package:flutter_http_restful_sample/model/user.dart';

class UserBloc extends Bloc<int, User> {
  //UserBloc(User initialState) : super(initialState);
  UserBloc() : super(initialState);

  //karena return nya berupa Object yaitu User, maka initialState tidak boleh null
  static User get initialState => UninitializedUser();

  @override
  Stream<User> mapEventToState(int event) async* {
    try {
      User user = await User.getUserFromAPI(event);
      yield user;
    } catch (_) {}
  }
}
