import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/user_bloc.dart';
import './ui/user_card.dart';

import './model/user.dart';

/*
TUJUAN MVVM : memisahkan state dan logic dari view, menjadi component lain  yang disebut view model (BLoC)
VIEW : beri tahu viewmodel ada aksi dari user
VIEWMODEL : merespon view dan memberi output berupa state
*/
class MvvmScreen extends StatelessWidget {
  static const routeName = 'mvvm_screen';
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    //ambil bloc nya
    //UserBloc bloc = context.bloc<UserBloc>(); //only work if stateful widget
    //UserBloc bloc = context.watch<UserBloc>();
    UserBloc bloc = context.select((UserBloc userBloc) => userBloc);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(
            'MVVM dengan BLoC',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
              ),
              onPressed: () {
                bloc.add(random.nextInt(10) + 1);
              },
              child: Text(
                'Pick Random User',
                style: TextStyle(color: Colors.white),
              ),
            ),
            //Bloc nya UserBloc, state return nya User
            BlocBuilder<UserBloc, User>(
              builder: (context, user) =>
                  (user is UninitializedUser) ? Container() : UserCard(user),
            ),
          ],
        ));
  }
}
