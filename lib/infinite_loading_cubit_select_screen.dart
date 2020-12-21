import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/mypost_cubit.dart';
import 'ui/post_item.dart';
import 'model/post.dart';

class InfiniteLoadingCubitSelectScreen extends StatefulWidget {
  static const routeName = "/infinite-loading-cubit-select";

  @override
  _InfiniteLoadingCubitSelectScreenState createState() =>
      _InfiniteLoadingCubitSelectScreenState();
}

class _InfiniteLoadingCubitSelectScreenState
    extends State<InfiniteLoadingCubitSelectScreen> {
  List<Post> _posts;
  bool _hasReachedMax;

  ScrollController controller = ScrollController();

  void onScroll() {
    //ujung bawah screen
    double maxScroll = controller.position.maxScrollExtent;
    //posisi kini screen
    double currentScroll = controller.position.pixels;
    if (currentScroll == maxScroll) {
      //context.bloc<MypostCubit>().cubitMyPost();
      context.read<MypostCubit>().cubitMyPost();
    }
  }

  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    controller.addListener(onScroll);

    //PERTAMA LOAD HALAMAN INI, EKSEKUSI Cubit nya
    if (_posts == null && _hasReachedMax == null) {
      context.watch<MypostCubit>().cubitMyPost();
    }

    //get data
    _posts = context
        .select<MypostCubit, List<Post>>((mypostCubit) => mypostCubit.posts);
    _hasReachedMax = context
        .select<MypostCubit, bool>((mypostCubit) => mypostCubit.hasReachedMax);

    //print(_hasReachedMax);

    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Infinite Loading with Cubit"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: _posts == null
            ? Center(
                child: SizedBox(
                  width: 130,
                  height: 130,
                  child: FlareActor(
                    "assets/loading_success_error.flr",
                    animation: "loading",
                  ),
                ),
              )
            : ListView.builder(
                //controller men-trigger cubit bloc
                controller: controller,
                itemCount: (_hasReachedMax) ? _posts.length : _posts.length + 1,
                itemBuilder: (context, index) => (index < _posts.length)
                    ? PostItem(_posts[index])
                    : Container(
                        child: Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
