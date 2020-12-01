part of 'mypost_cubit.dart';

@immutable
abstract class MypostState {}

//class MypostInitial extends MypostState {}

//untuk load datanya
class MyPostLoaded extends MypostState {
  /*  List<Post> posts;
  //untuk test apakah sudah load smua data di API, jika sudah maka true
  bool hasReachedMax; */

  final List<Post> posts;
  //untuk test apakah sudah load smua data di API, jika sudah maka true
  final bool hasReachedMax;

  //MyPostLoaded({this.posts, this.hasReachedMax});
  //https://dart.dev/guides/language/language-tour#initializer-list
  //the order of execution is as follows:
  // 1. initializer list
  // 2. superclass’s no-arg constructor
  // 3. main class’s no-arg constructor

  MyPostLoaded({posts, hasReachedMax})
      //: _posts = posts ?? null, //default variabel yang uninitialized adalah null, apapun tipe nya
      //posts yang sebelah kiri '=' milik kelas, dan posts yang disebelah kanan milik MyPostLoaded({posts, hasReachedMax})
      //Disini uniknya flutter, final variable biasanya harus diinisialisasi, tapi menggunakan initializer, bisa diinisialiasi disini
      : posts = posts,
        hasReachedMax = hasReachedMax ?? false;

  /* List<Post> get posts => _posts;
  bool get hasReachedMax => _hasReachedMax; */

  //method untuk copy PostLoaded
  MyPostLoaded copyWith({List<Post> posts, bool hasReachedMax}) {
    /*
      jika sudah dipanggil method copyWith maka proses penambahan post terhenti
      - MyPostLoaded(post:null, hasReached: true)
      - state saat ini adalah yg lama (this.posts)
    */
    /* print(hasReachedMax);
    print(this.hasReachedMax);
    print(hasReachedMax ?? this.hasReachedMax); */
    //Jika copyWith(posts) nya tidak null, maka pake post nya post copywith, selain itu pake posts ya kelas (post yang existing)
    //jika copywith(hasReachedMax) nya tidak null, maka pake hasReachedMax nya copywith, selain itu pake punyanya kelas (this.hasReachedMax)
    return MyPostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
