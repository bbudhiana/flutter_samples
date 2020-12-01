import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_restful_sample/model/post.dart';

class PostEvent {}

class PostInitialEvent extends PostEvent {}

abstract class PostState {}

//untuk initial data
class PostUninitialized extends PostState {}

//untuk load datanya
class PostLoaded extends PostState {
  List<Post> posts;
  //untuk test apakah sudah load smua data di API, jika sudah maka true
  bool hasReachedMax;

  PostLoaded({this.posts, this.hasReachedMax});

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
  PostBloc() : super(PostUninitialized());

  //dipasang inisialState nya PostUninitialized() karena state bukan null or 0, tapi class PostState
  //static PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    List<Post> posts;

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

      //ambil post berikutnya dengan parameter start berasal dari jumlah post sebelumnya
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
