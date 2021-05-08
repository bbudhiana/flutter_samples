part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

//state awal
class AuthenticationInitial extends AuthenticationState {}

//state loading
class AuthenticationLoading extends AuthenticationState {}

//state tidak ter-authentication
class AuthenticationNotAuthenticated extends AuthenticationState {}

//state ter-authentication (ambil data user nya)
class AuthenticationAuthenticated extends AuthenticationState {
  final Myuser user;

  AuthenticationAuthenticated({@required this.user});

  @override
  List<Object> get props => [user];
}

//state gagal authentication
class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
