import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/model/myuser.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

//state loading
class AuthenticationLoading extends AuthenticationState {}

//state tidak ter-authentication
class UnAuthenticated extends AuthenticationState {}

//state ter-authentication
class Authenticated extends AuthenticationState {
  final Myuser user;

  Authenticated({@required this.user});

  @override
  List<Object> get props => [user];
}

//state gagal ter-authentication, misal server putus / internet tidak ada saat proses getCurrentUser
class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
