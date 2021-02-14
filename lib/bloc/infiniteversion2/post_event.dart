import 'package:equatable/equatable.dart';

//our PostBloc will be receiving PostEvents and converting them to PostStates.
//We have defined all of our PostEvents (PostFetched) so next let’s define our PostState.
abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostEventInitial extends PostEvent {}

class PostFetched extends PostEvent {}
