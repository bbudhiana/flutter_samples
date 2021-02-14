import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'post.dart';

class PostBlocVersion2 extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBlocVersion2({@required this.httpClient}) : super(PostInitial());

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    Stream<PostEvent> events,
    TransitionFunction<PostEvent, PostState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    List<Post> posts;

    //sudah pernah ke halaman ini (sudah terjadi PostUninitialized), maka PostInitialEvent ubah lagi ke PostUninitialized agar load data terbaru
    if (event is PostEventInitial) {
      //print('Post inisial');
      yield PostInitial();
    }
    //belum load data atau baru awal sebagai initial (baru pertama kali buka page), state = current state, event = current event
    if (state is PostInitial) {
      posts = await _fetchPosts(0, 20);
      yield PostSuccess(posts: posts, hasReachedMax: false);
    }
    //udah pernah load
    else {
      //print('Post lebih dari 10');
      //postLoaded mengambil PostLoaded saat ini dari state
      PostSuccess postSuccess = state as PostSuccess;

      //ambil post berikutnya dengan parameter start berasal dari jumlah post sebelumnya (limit, quantity)
      posts = await _fetchPosts(postSuccess.posts.length, 20);
      /*
      jika posts yang terambil kosong,maka kembalikan post sebelumnya dan kasih hasReachedMax=true
      jika post belum empty, maka kembalikan PostLoaded = post lalu (postLoaded.posts) + post saat ini (posts) dan hasReachedMax=false
      */
      yield (posts.isEmpty)
          ? postSuccess.copyWith(hasReachedMax: true)
          : PostSuccess(posts: postSuccess.posts + posts, hasReachedMax: false);
    }

    /* final currentState = state;
    if (event is PostFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostInitial) {
          final posts = await _fetchPosts(0, 20);
          yield PostSuccess(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostSuccess) {
          final posts = await _fetchPosts(currentState.posts.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostSuccess(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield PostFailure();
      }
    } */
  }

  bool _hasReachedMax(PostState state) =>
      state is PostSuccess && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Post(
          id: rawPost['id'],
          title: rawPost['title'],
          body: rawPost['body'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
