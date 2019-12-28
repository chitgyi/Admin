import 'package:admin/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User userFromFirebase(FirebaseUser user) {
    return user == null ? null : User(user.uid);
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(userFromFirebase);
  }

  Future signInWithEmail({email: String, password: String}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userFromFirebase(result.user);
    } catch (e) {
      return null;
    }
  }
  
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}