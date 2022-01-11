import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/models/user_model.dart';
import 'package:kurs3_sabak9/services/authentication/auth_services.dart';
import 'package:kurs3_sabak9/services/register/register_service.dart';
import 'package:kurs3_sabak9/utilities/app_utils/dialogs/error_dialog_util.dart';

class RegisterRepo {
  Future<UserModel> registerWithEmail(
      BuildContext context, String email, String password) async {
    final _authData =
        await authServices.createUserWithEmailAndPassword(email, password);

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

      return null;
    }

    if (_authData is UserCredential) {
      final _userData = await registerService.createUser(_authData.user);

      if (_userData is String) {
        final _isUserDeleted = await authServices
            .deleteUserWithEmail(FirebaseAuth.instance.currentUser);

        if (_isUserDeleted) {
          ErrorDialogUtil.showErrorDialog(
            context,
            'Couldn\'t create user, please try again!',
          );
        } else {
          await authServices
              .deleteUserWithEmail(FirebaseAuth.instance.currentUser)
              .then(
                (value) => ErrorDialogUtil.showErrorDialog(
                  context,
                  'Couldn\'t create user, please try again!',
                ),
              );
        }
      } else if (_userData is UserModel) {
        return _userData;
      }
    }

    return null;
  }
}

final RegisterRepo registerRepo = RegisterRepo();
