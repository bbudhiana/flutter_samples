import 'package:flutter/material.dart';
import '../model/post_dua.dart';

class PostItemDua extends StatelessWidget {
  final Postdua postdua;

  PostItemDua(this.postdua);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(postdua.id.toString()),
          Container(
            width: (MediaQuery.of(context).size.width - 40) * 7 / 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postdua.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(postdua.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
