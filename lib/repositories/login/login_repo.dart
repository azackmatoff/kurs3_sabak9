import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/models/user_model.dart';
import 'package:kurs3_sabak9/pages/chat_page.dart';
import 'package:kurs3_sabak9/services/authentication/auth_services.dart';
import 'package:kurs3_sabak9/services/login/login_services.dart';
import 'package:kurs3_sabak9/utilities/app_utils/dialogs/error_dialog_util.dart';

class LoginRepo {
  static Future<void> loginWithEmail(
      BuildContext context, String email, String password) async {
    final _authData =
        await authServices.signInWithEmailAndPassword(email, password);

    if (_authData is String) {
      if (_authData == 'invalid-email') {
        ErrorDialogUtil.showErrorDialog(
            context, 'You have entered wrong email! Please try again!');
      } else if (_authData == 'user-disabled') {
        ErrorDialogUtil.showErrorDialog(
            context, 'Your account has been disabled!');
      } else if (_authData == 'user-not-found') {
        ErrorDialogUtil.showErrorDialog(context,
            'User not found! Please enter correct email! If you\'re not registered, please get registered!');
      } else if (_authData == 'wrong-password') {
        ErrorDialogUtil.showErrorDialog(
            context, 'You have entered wrong password! Please try again!');
      } else if (_authData == 'weak-password') {
        ErrorDialogUtil.showErrorDialog(
            context, 'Weak password! Please try with a stronger password!');
      } else if (_authData == 'email-already-in-use') {
        ErrorDialogUtil.showErrorDialog(
            context, 'Email is already in use! Please try with another email!');
      } else {
        ErrorDialogUtil.showErrorDialog(
            context, 'Something went wrong! Please try again!');
      }
    }

    if (_authData is UserCredential) {
      final _userId = _authData.user.uid;
      final _userData = await loginServices.getUser(_userId);

      if (_userData.exists) {
        final data = _userData.data() as Map<String, dynamic>;

        final _userModel = UserModel.fromJson(data, _userId);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              userModel: _userModel,
            ),
          ),
        );
      } else {
        ErrorDialogUtil.showErrorDialog(context,
            'User not found! Please enter correct email! If you\'re not registered, please get registered!');
      }
    }
  }
}
