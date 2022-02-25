import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///
  /// return the Future with firebase user object FirebaseUser if one exists
  ///
  Future<dynamic> getUser() async {
    return _auth.currentUser;
  }

  // wrapping the firebase calls
  void logout() async {
    FirebaseAuth.instance.signOut();
  }

  ///
  /// wrapping the firebase call to signInWithEmailAndPassword
  /// `email` String
  /// `password` String
  ///
  Future<User?> loginUser({required String email, required String password}) async {
    try {
      UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      print("User Logged in: ${result.user?.email}");
      // something changed, notify the listeners...
      // notifyListeners();
      return result.user;
    } on FirebaseAuthException catch (e) {
      // throw the Firebase AuthException that we caught
      print('Login error: ${e.code}');
      throw e;
    }
  }

  // wrappinhg the firebase calls
  Future<void> createUser({required String fullName, required String email, required String password, required String phoneNr}) async {
    var u = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

    await _firestore.collection('users').doc(u.user?.uid).set({
      'uid': u.user?.uid,
      'email': email,
      'fullName': fullName,
      'phoneNr': phoneNr,
    });
    return await u.user?.updateDisplayName(fullName);
  }

  Future<void> sendForgotPasswordEmail(String email) {
    var result = FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    //notifyListeners();
    return result;
  }
}
