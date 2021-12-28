import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/post.dart';

abstract class PostEvent {}

class PostNextEvent extends PostEvent {}

class PostInitialEvent extends PostEvent {}

abstract class PostState {
  final List<Post> posts;
  final bool hasReachedMax;
  const PostState({this.posts, this.hasReachedMax});
}

//untuk initial data atau state saat pertama kali dibuat
class PostUninitialized extends PostState {
  const PostUninitialized() : super(posts: null, hasReachedMax: false);
}

//untuk load datanya atau state setelah diolah
class PostLoaded extends PostState {
  //List<Post> posts;
  //untuk test apakah sudah load smua data di API, jika sudah maka true
  //bool hasReachedMax;

  PostLoaded({List<Post> posts, bool hasReachedMax})
      : super(posts: posts, hasReachedMax: hasReachedMax);

  //method untuk copy PostLoaded
  PostLoaded copyWith({List<Post> posts, bool hasReachedMax}) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class PostBloc extends Bloc<PostEvent, PostState> {
  //PostBloc() : super(initialState);
  //PostBloc() : super();

  PostBloc() : super(const PostUninitialized()) {
    on<PostInitialEvent>((event, emit) async {
      //agar kembali menampilkan loading, kembalikan state ke PostUninitialized
      if (state is PostLoaded) {
        emit(PostUninitialized());
      }
      List<Post> posts = [];
      posts = await Post.connectToApi(0, 10);
      emit(PostLoaded(posts: posts, hasReachedMax: false));
    });

    on<PostNextEvent>((event, emit) async {
      List<Post> posts;
      //declare state nya sebagai PostLoaded agar bisa ambil function postLoaded.copyWith
      PostLoaded postLoaded = state as PostLoaded;

      //ambil post berikutnya dengan parameter start berasal dari jumlah post sebelumnya (limit, quantity)
      posts = await Post.connectToApi(postLoaded.posts.length, 10);
      /*
      jika posts yang terambil kosong,maka kembalikan post sebelumnya dan kasih hasReachedMax=true
      jika post belum empty, maka kembalikan PostLoaded = post lalu (postLoaded.posts) + post saat ini (posts) dan hasReachedMax=false
      */
      (posts.isEmpty)
          ? emit(postLoaded.copyWith(hasReachedMax: true))
          : emit(PostLoaded(
              posts: postLoaded.posts + posts, hasReachedMax: false));
    });
  }

  //dipasang inisialState nya PostUninitialized() karena state bukan null or 0, tapi class PostState
  //static PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    List<Post> posts;

    /* if (event is PostEvent) {
      if (state is PostUninitialized) {
        posts = await Post.connectToApi(0, 10);
        yield PostLoaded(posts: posts, hasReachedMax: false);
      } else {
        //print('Post lebih dari 10');
        //postLoaded mengambil PostLoaded saat ini dari state
        PostLoaded postLoaded = state as PostLoaded;

        //ambil post berikutnya dengan parameter start berasal dari jumlah post sebelumnya (limit, quantity)
        posts = await Post.connectToApi(postLoaded.posts.length, 10);
        /*
        jika posts yang terambil kosong,maka kembalikan post sebelumnya dan kasih hasReachedMax=true
        jika post belum empty, maka kembalikan PostLoaded = post lalu (postLoaded.posts) + post saat ini (posts) dan hasReachedMax=false
        */
        yield (posts.isEmpty)
            ? postLoaded.copyWith(hasReachedMax: true)
            : PostLoaded(posts: postLoaded.posts + posts, hasReachedMax: false);
      }
    } */

    //sudah pernah ke halaman ini (sudah terjadi PostUninitialized), maka PostInitialEvent ubah lagi ke PostUninitialized agar load data terbaru
    if (event is PostInitialEvent) {
      //print('Post inisial');
      yield PostUninitialized();
    }
    //belum load data atau baru awal sebagai initial (baru pertama kali buka page), state = current state, event = current event
    if (state is PostUninitialized) {
      //print('Post awal');
      posts = await Post.connectToApi(0, 10);
      yield PostLoaded(posts: posts, hasReachedMax: false);
    }
    //udah pernah load
    else {
      //print('Post lebih dari 10');
      //postLoaded mengambil PostLoaded saat ini dari state
      PostLoaded postLoaded = state as PostLoaded;

      //ambil post berikutnya dengan parameter start berasal dari jumlah post sebelumnya (limit, quantity)
      posts = await Post.connectToApi(postLoaded.posts.length, 10);
      /*
      jika posts yang terambil kosong,maka kembalikan post sebelumnya dan kasih hasReachedMax=true
      jika post belum empty, maka kembalikan PostLoaded = post lalu (postLoaded.posts) + post saat ini (posts) dan hasReachedMax=false
      */
      yield (posts.isEmpty)
          ? postLoaded.copyWith(hasReachedMax: true)
          : PostLoaded(posts: postLoaded.posts + posts, hasReachedMax: false);
    }
  }
}
