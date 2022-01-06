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
}

final AuthServices authServices = AuthServices();
