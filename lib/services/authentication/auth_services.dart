import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log('AuthServices.signInWithEmailAndPassword FirebaseAuthException error.code ===>> ${e.code}');
      return e.code;
    } catch (e) {
      log('AuthServices.signInWithEmailAndPassword  error ===>> $e');
      throw Exception(e);
    }
  }

  Future<dynamic> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log('AuthServices.createUserWithEmailAndPassword FirebaseAuthException error.code ===>> ${e.code}');
      return e.code;
    } catch (e) {
      log('AuthServices.createUserWithEmailAndPassword  error ===>> $e');
      throw Exception(e);
    }
  }

  Future<bool> deleteUserWithEmail(User currentUser) async {
    return currentUser
        .delete()
        .then((_) => true)
        .onError((error, stackTrace) => false);
  }

  Future<bool> signOut() async {
    return firebaseAuth
        .signOut()
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }
}

final AuthServices authServices = AuthServices();
