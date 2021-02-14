import 'package:equatable/equatable.dart';

import 'post.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

//will tell the presentation layer it needs to render a loading indicator while the initial batch of posts are loaded
class PostInitial extends PostState {}

//will tell the presentation layer that an error has occurred while fetching posts
class PostFailure extends PostState {}

//will tell the presentation layer it has content to render
class PostSuccess extends PostState {
  //will be the List<Post> which will be displayed
  final List<Post> posts;

  //will tell the presentation layer whether or not it has reached the maximum number of posts
  final bool hasReachedMax;

  const PostSuccess({
    this.posts,
    this.hasReachedMax,
  });

  //We implemented copyWith so that we can copy an instance of PostSuccess and update zero or more properties conveniently
  PostSuccess copyWith({
    List<Post> posts,
    bool hasReachedMax,
  }) {
    return PostSuccess(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}
