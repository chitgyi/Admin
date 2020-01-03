import 'package:admin/components/MenuItem.dart';
import 'package:admin/models/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> posts;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("posts")
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text("Loading..."),
          );
        } else if (snapshot.data.documents.length < 1) {
          return Center(
            child: Text("No Data Here!"),
          );
        }
        List<Post> posts =
            snapshot.data.documents.map((f) => Post.fromDb(f)).toList();
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return MenuItem(posts[index]);
          },
        );
      },
    );
  }
}

// SingleChildScrollView(
//         padding: EdgeInsets.all(5.0),
//         child: FutureBuilder<List<Post>>(
//           future: DataRepo().allPost(),
//           builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
//             if(snapshot.hasData){
//               return Column(children: snapshot.data.map((f)=>MenuItem(f)).toList()
//               );
//             }
//             return Text("No Data");
//           },
//         ));
