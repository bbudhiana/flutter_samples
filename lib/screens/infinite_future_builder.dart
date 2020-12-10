import 'package:flutter/material.dart';
import 'package:flutter_samples/model/post_model_second.dart';
import 'package:flutter_samples/widgets/post_item.dart';

class InfiniteFutureBuilder extends StatefulWidget {
  @override
  _InfiniteFutureBuilderState createState() => _InfiniteFutureBuilderState();
}

class _InfiniteFutureBuilderState extends State<InfiniteFutureBuilder> {
  final scrollController = ScrollController();
  PostsModel postsModel;

  @override
  void initState() {
    postsModel = PostsModel();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        //posts.loadMore();
        PostsModel().loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsModel.loadMore(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print('belum ada data');
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print('ada data');
          return RefreshIndicator(
            onRefresh: postsModel.refresh,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              controller: scrollController,
              separatorBuilder: (context, index) => Divider(),
              itemCount: snapshot.data.length + 1,
              itemBuilder: (BuildContext _context, int index) {
                if (index < snapshot.data.length) {
                  return PostItem(post: snapshot.data[index]);
                } else if (postsModel.hasMore) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(
                      child: Text('Nothing More to Load!'),
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}
