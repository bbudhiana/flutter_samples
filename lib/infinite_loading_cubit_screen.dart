import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './cubit/mypost_cubit.dart';
import './ui/post_item.dart';
import 'model/post.dart';

class InfiniteLoadingCubitScreen extends StatefulWidget {
  static const routeName = "/infinite-loading-cubit";

  @override
  _InfiniteLoadingCubitScreenState createState() =>
      _InfiniteLoadingCubitScreenState();
}

class _InfiniteLoadingCubitScreenState
    extends State<InfiniteLoadingCubitScreen> {
  ScrollController controller = ScrollController();
  MypostCubit mybloc;

  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onScroll() {
    //ujung bawah screen
    double maxScroll = controller.position.maxScrollExtent;
    //posisi kini screen
    double currentScroll = controller.position.pixels;

    /*
    print('currentScroll : ${currentScroll}');
    print('maxScroll : ${maxScroll}');
    */

    if (currentScroll == maxScroll) {
      //context.bloc<MypostCubit>().cubitMyPost();
      context.read<MypostCubit>().cubitMyPost();
    }
  }

  @override
  void didChangeDependencies() {
    //context.bloc<MypostCubit>().cubitMyPost();

    //TRIGGER PERTAMA KALI UBAH STATE NYA OLEH CUBIT
    context.read<MypostCubit>().cubitMyPost();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //mybloc = context.bloc<MypostCubit>();
    //mybloc = context.read<MypostCubit>();
    controller.addListener(onScroll);

    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Infinite Loading with Cubit"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: BlocBuilder<MypostCubit, MypostState>(
          //cubit: mybloc, //optional
          builder: (context, state) {
            MyPostLoaded postLoaded = state as MyPostLoaded;
            //Jika sudah sampai akhir record
            //First, you must ensure that you are always returning a widget
            //Second, you can schedule the SnackBar for the end of the frame
            //https://stackoverflow.com/questions/54230331/what-is-the-fancy-way-to-use-snackbar-in-streambuilder
            if (postLoaded.hasReachedMax) {
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _showRecordHasReachedMax(context));
            }
            //dari mainpage
            //if (state is MypostInitial) {
            if (postLoaded.posts == null) {
              //Jika data belum ada (posts=null dan hasReachedMax=true) maka kembalikan container saja
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
              //MyPostLoaded postLoaded = state as MyPostLoaded;
              //print("===> " + postLoaded.posts.length.toString());
              return ListView.builder(
                //controller men-trigger cubit bloc
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

  void _showRecordHasReachedMax(BuildContext context) {
    //_scaffoldKey.currentState
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Record has reached maximum..."),
            Icon(Icons.done),
          ],
        ),
        backgroundColor: Color(0xff1565c0),
      ));
    /* Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Record has reached maximum..."),
            Icon(Icons.done),
          ],
        ),
        backgroundColor: Color(0xff1565c0),
      )); */
  }
}
