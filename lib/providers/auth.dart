// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  /*String _userId;
  String _userName;
  String _userEmail;
*/
  Stream<User> userState() {
    return FirebaseAuth.instance.authStateChanges();
  }

  String get userId {
    // FirebaseAuth.instance.currentUser.uid;
    return FirebaseAuth.instance.currentUser.uid;
  }

  String get userName {
    return FirebaseAuth.instance.currentUser.displayName;
  }

  String get userEmail {
    return FirebaseAuth.instance.currentUser.email;
  }

  Future<void> login(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userCredential.user.updateProfile(
        displayName: name,
      );

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
