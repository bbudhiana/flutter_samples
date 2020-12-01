import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_restful_sample/bloc/post_bloc.dart';
import 'package:flutter_http_restful_sample/ui/post_item.dart';

class InfiniteLoadingScreen extends StatefulWidget {
  static const routeName = "/infinite-loading";

  @override
  _InfiniteLoadingScreenState createState() => _InfiniteLoadingScreenState();
}

class _InfiniteLoadingScreenState extends State<InfiniteLoadingScreen> {
  ScrollController controller = ScrollController();
  PostBloc bloc;

  void onScroll() {
    //ujung bawah screen
    double maxScroll = controller.position.maxScrollExtent;
    //posisi kini screen
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) {
      bloc.add(PostEvent());
    }
  }

  @override
  void didChangeDependencies() {
    //PostBloc bloc = BlocProvider.of<PostBloc>(context); //lama

    //context.bloc<PostBloc>()..add(PostEventInitial());
    //TRIGGER PERUBAHANNYA SAAT WIDGET INI DIBUKA DENGAN PostInitialEvent()
    //context.bloc<PostBloc>()..add(PostInitialEvent());
    context.read<PostBloc>()..add(PostInitialEvent());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //agar langsung memanggil data yang pertama, maka gunakan add(PostEvent())
    //PostBloc bloc = context.bloc<PostBloc>()..add(PostEvent());

    //INI ADALAH PERINTAH UNTUK AMBIL BLOC PROVIDER DI ROOT/MAIN PAGE
    //bloc = context.bloc<PostBloc>();
    bloc = context.read<PostBloc>();
    controller.addListener(onScroll);

    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite Loading with BLoC"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            //dari mainpage
            if (state is PostUninitialized) {
              return Center(
                child: SizedBox(
                  //width: 30,
                  //height: 30,
                  //child: CircularProgressIndicator(),
                  width: 130,
                  height: 130,
                  child: FlareActor(
                    "assets/loading_success_error.flr",
                    animation: "loading",
                  ),
                ),
              );
            } else {
              PostLoaded postLoaded = state as PostLoaded;
              //print("===> " + postLoaded.posts.length.toString());
              return ListView.builder(
                //controller men-trigger event bloc
                controller: controller,
                itemCount: (postLoaded.hasReachedMax)
                    ? postLoaded.posts.length
                    : postLoaded.posts.length + 1,
                itemBuilder: (context, index) =>
                    (index < postLoaded.posts.length)
                        ? PostItem(postLoaded.posts[index])
                        : Container(
                            child: Center(
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
              );
            }
          },
        ),
      ),
    );
  }
}