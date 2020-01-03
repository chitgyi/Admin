import 'package:admin/components/progress_dialog.dart';
import 'package:admin/models/posts.dart';
import 'package:admin/screens/edit_news.dart';
import 'package:admin/services/data.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  final New post;
  NewsItem(this.post);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Column(
              children: <Widget>[
                Ink.image(
                  image: NetworkImage(post.url),
                  fit: BoxFit.fill,
                  height: 250,
                  width: double.infinity,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    post.title,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (cxt) => EditNews(post)));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 30,
                  ),
                  onPressed: () {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.SCALE,
                        tittle: 'Warning',
                        desc: 'Are you sure want to delete?',
                        dismissOnTouchOutside: false,
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          dialog(context).show();
                          await DataRepo().deleteNews(
                              url: post.url.substring(91, 108), id: post.id);
                          dialog(context).hide();
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Deleted!"),
                            duration: Duration(milliseconds: 1500),
                          ));
                        }).show();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
