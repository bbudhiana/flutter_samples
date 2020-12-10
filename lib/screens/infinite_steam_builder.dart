import 'package:flutter/material.dart';
import 'package:flutter_samples/model/post_model.dart';
import 'package:flutter_samples/widgets/post_item.dart';

class InfiniteStreamBuilder extends StatefulWidget {
  @override
  _InfiniteStreamBuilderState createState() => _InfiniteStreamBuilderState();
}

class _InfiniteStreamBuilderState extends State<InfiniteStreamBuilder> {
  final scrollController = ScrollController();
  PostsModel posts;

  @override
  void initState() {
    posts = PostsModel();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        posts.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: posts.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print('belum ada data');
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print('ada data');
          return RefreshIndicator(
            onRefresh: posts.refresh,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              controller: scrollController,
              separatorBuilder: (context, index) => Divider(),
              itemCount: snapshot.data.length + 1,
              itemBuilder: (BuildContext _context, int index) {
                if (index < snapshot.data.length) {
                  return PostItem(post: snapshot.data[index]);
                } else if (posts.hasMore) {
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
