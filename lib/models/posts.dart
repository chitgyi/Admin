import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String title;
  final String body;
  final String url;
  final String type;
  final String id;
  Post({this.title, this.body, this.url, this.type, this.id});

  Post.fromDb(DocumentSnapshot snapshot)
      : title = snapshot.data['title'],
        body = snapshot.data['body'],
        url = snapshot.data['url'],
        type = snapshot.data['foodType'],
        id = snapshot.documentID;
}
class New {
  final String title;
  final String body;
  final String url;
  final String id;
  New({this.title, this.body, this.url, this.id});

  New.fromDb(DocumentSnapshot snapshot)
      : title = snapshot.data['title'],
        body = snapshot.data['body'],
        url = snapshot.data['url'],
        id = snapshot.documentID;
}
