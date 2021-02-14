import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/infiniteversion2/bloc.dart';
import 'bloc/infiniteversion2/bottom_loader.dart';
import 'bloc/infiniteversion2/post_widget.dart';

//base on : https://bloclibrary.dev/#/flutterinfinitelisttutorial
class InfiniteLoadingScreen2 extends StatefulWidget {
  static const routeName = "/infinite-loading-screen2";

  @override
  _InfiniteLoadingScreen2State createState() => _InfiniteLoadingScreen2State();
}

class _InfiniteLoadingScreen2State extends State<InfiniteLoadingScreen2> {
  //definisi controller untuk tangkap event dari user
  final _scrollController = ScrollController();

  //misal baris layar kita adalah 200
  final _scrollThreshold = 200.0;
  PostBlocVersion2 _postBloc;

  //saat pertama kali masuk widget
  /* @override
  void initState() {
    super.initState();
    //pasang controller _scollController ke method _onScroll, langsung trigger _onScroll
    //In initState, we add a listener to our ScrollController so that we can respond to scroll events.
    //We also access our PostBloc instance via BlocProvider.of<PostBloc>(context)
    _scrollController.addListener(_onScroll);

    //pasang _postBloc sebagai Provider Bloc
    _postBloc = BlocProvider.of<PostBlocVersion2>(context);
  } */

  @override
  void initState() {
    // TODO: implement initState
    context.read<PostBlocVersion2>()..add(PostEventInitial());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //context.read<PostBlocVersion2>()..add(PostInitialEvent());
    super.didChangeDependencies();
  }

  //kalo keluar widget jangan lupa di dispose agar memory tidak leak
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //Fungsi untuk scroll
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      context.read<PostBlocVersion2>()..add(PostFetched());
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(_onScroll);
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Loading'),
      ),
      body: BlocBuilder<PostBlocVersion2, PostState>(
        builder: (context, state) {
          /* if (state is PostInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (state is PostSuccess) {
              if (state.posts.isEmpty) {
                return Center(
                  child: Text('no posts'),
                );
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.posts.length
                      ? BottomLoader()
                      : PostWidget(post: state.posts[index]);
                },
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
                controller: _scrollController,
              );
            }
          } */

          if (state is PostInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostFailure) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is PostSuccess) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text('no posts'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.posts.length
                    ? BottomLoader()
                    : PostWidget(post: state.posts[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              controller: _scrollController,
            );
          }
        },
      ),
    );
  }
}
