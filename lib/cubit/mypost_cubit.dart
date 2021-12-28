import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../model/post.dart';

part 'mypost_state.dart';

/* class MypostCubit extends Cubit<MypostState> {
  //MypostCubit() : super(MypostInitial());
  MypostCubit() : super(MyPostLoaded());

  MyPostLoaded _emitMyPost;
  List<Post> _posts;
  bool _hasReachedMax = false;

  List<Post> get posts => _posts;
  bool get hasReachedMax => _hasReachedMax;

  void cubitMyPost() async {
    List<Post> posts;

    //ambil posts telah ada di state (ini adalah current state)
    MyPostLoaded postLoaded = state as MyPostLoaded;

    //if (state is MypostInitial) {
    if (postLoaded.posts == null) {
      posts = await Post.connectToApi(0, 10);

      //jika belum ada datanya (null maka) state hasReachedMax=true dan posts=null;
      //selainnya maka ambil dan kembalikan dengan state isi data dan hasReachedMax=false;
      if (posts == null) {
        _hasReachedMax = true;
        _posts = null;
        _emitMyPost = postLoaded.copyWith(hasReachedMax: true);
      } else {
        _posts = posts;
        _emitMyPost = MyPostLoaded(posts: posts, hasReachedMax: false);
      }
    } else {
      //ambil post berikutnya dengan parameter start berasal dari jumlah post sebelumnya
      posts = await Post.connectToApi(postLoaded.posts.length, 10);

      _hasReachedMax = (posts.isEmpty) ? true : false;
      _posts = (posts.isEmpty) ? postLoaded.posts : postLoaded.posts + posts;

      //kasih trigger untuk di widget agar proses bisa berhenti, dengan kasih hasReachedMax: true
      _emitMyPost = (posts.isEmpty)
          ? postLoaded.copyWith(hasReachedMax: true)
          : MyPostLoaded(posts: postLoaded.posts + posts, hasReachedMax: false);
    }
    emit(_emitMyPost);
  }
} */

class MypostCubit extends Cubit<MypostState> {
  //MypostCubit() : super(MypostInitial());
  MypostCubit() : super(MyPostLoaded());

  MyPostLoaded emitMyPost = MyPostLoaded();
  List<Post> posts = [];
  bool hasReachedMax = false;

  void cubitMyPost() async {
    List<Post> _posts;

    //ambil posts telah ada di state (ini adalah current state)
    MyPostLoaded postLoaded = state as MyPostLoaded;

    //if (state is MypostInitial) {
    if (postLoaded.posts == null) {
      _posts = await Post.connectToApi(0, 10);

      //jika belum ada datanya (null maka) state hasReachedMax=true dan posts=null;
      //selainnya maka ambil dan kembalikan dengan state isi data dan hasReachedMax=false;
      if (_posts == null) {
        this.hasReachedMax = true;
        this.posts = null;
        this.emitMyPost = postLoaded.copyWith(hasReachedMax: true);
      } else {
        this.posts = _posts;
        this.emitMyPost = MyPostLoaded(posts: _posts, hasReachedMax: false);
      }
    } else {
      //ambil post berikutnya dengan parameter start berasal dari jumlah post sebelumnya
      _posts = await Post.connectToApi(postLoaded.posts.length, 10);

      this.hasReachedMax = (_posts.isEmpty) ? true : false;
      this.posts =
          (_posts.isEmpty) ? postLoaded.posts : postLoaded.posts + _posts;

      //kasih trigger untuk di widget agar proses bisa berhenti, dengan kasih hasReachedMax: true
      this.emitMyPost = (_posts.isEmpty)
          ? postLoaded.copyWith(hasReachedMax: true)
          : MyPostLoaded(
              posts: postLoaded.posts + _posts, hasReachedMax: false);
    }
    emit(this.emitMyPost);
  }
}
