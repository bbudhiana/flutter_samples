import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/model/post_dua.dart';

class InfiniteState extends Equatable {
  const InfiniteState();

  @override
  List<Object> get props => [];
}

//state Initial atau saat widget dibentuk/diakses
class InfiniteInitial extends InfiniteState {}

//state loading
class InfiniteLoading extends InfiniteState {}

//state success
class InfiniteSuccess extends InfiniteState {
  final List<Postdua> posts;
  final bool hasReachedMax;

  InfiniteSuccess({@required this.posts, @required this.hasReachedMax});

  @override
  List<Object> get props => [posts, hasReachedMax];
}

//state gagal ambil data
class InfiniteFailure extends InfiniteState {
  final String message;

  InfiniteFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
