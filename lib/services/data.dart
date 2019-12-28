import 'dart:io';
import 'package:admin/models/menu_item.dart';
import 'package:admin/models/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataRepo {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final Firestore _firestore = Firestore.instance;

  uploadImage(File image) async {
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("postImages")
        .child("${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");
    StorageUploadTask uploadTask = reference.putFile(image);
    StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    return (await downloadUrl.ref.getDownloadURL());
  }

  createPost({String title, String body, String url, FoodType foodType}) async {
    Map<String, String> post = {
      "title": title,
      "body": body,
      "url": url,
      "foodType": foodType.toString()
    };
    return await _firestore.collection("posts").add(post);
  }
  Future<List<Post>> allPost() async {
    List<Post> posts;
    QuerySnapshot doc = await _firestore.collection("posts").getDocuments();
    posts = doc.documents.map((f) => Post.fromDb(f)).toList();
    return posts;
  }


  Future<bool> deletePost({String url, String id}) async {
    await _firebaseStorage.ref().child("postImages").child(url).delete();
    await _firestore.collection("posts").document(id).delete();
    return true;
  }

  Future updatePost(Post post) async {
    Map<String, String> data = {
      "title": post.title,
      "body": post.body,
      "url": post.url,
      "foodType": post.type
    };
    await _firestore.collection("posts").document(post.id).updateData(data);
    return 1;
  }
}
