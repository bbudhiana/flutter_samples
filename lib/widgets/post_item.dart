import 'package:flutter/material.dart';
import 'package:flutter_samples/model/post_model.dart';

class PostItem extends StatelessWidget {
  //final PostModel post;
  final PostModel2 post;

  const PostItem({
    Key key,
    @required this.post,
  })  : assert(post != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    /* return ListTile(
      leading: Image.network(
        post.avatar,
        width: 60.0,
        height: 60.0,
      ),
      title: Text(post.body),
    ); */
    return ListTile(
      leading: Text(post.id.toString()),
      title: Text(post.title),
      //subtitle: Text(post.body),
    );
  }
}
