import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kurs3_sabak9/models/user_model.dart';
import 'package:kurs3_sabak9/utilities/firestore_collections/firestore_collections.dart';

class RegisterService {
  Future<dynamic> createUser(User _user) async {
    return FirestoreCollections.userReference.doc(_user.uid).set({
      'displayName': _user.displayName ?? 'Display name',
      'email': _user.email,
      'userId': _user.uid,
    }).then((_) async {
      final docSnapshot =
          await FirestoreCollections.userReference.doc(_user.uid).get();

      if (docSnapshot.exists) {
        final _data = docSnapshot.data() as Map<String, dynamic>;

        final _userModel = UserModel.fromJson(_data, _user.uid);

        log('_userModel =====> $_userModel');

        return _userModel;
      } else {
        return 'user_not_created';
      }

      /// Future .then menen ishtoo
      //  return FirestoreCollections.userReference
      //     .doc(_user.uid)
      //     .get()
      //     .then((docSnapshot) {
      //   if (docSnapshot.exists) {
      //     final _data = docSnapshot.data() as Map<String, dynamic>;

      //     final _userModel = UserModel.fromJson(_data, _user.uid);

      //     log('_userModel =====> $_userModel');

      //     return _userModel;
      //   } else {
      //     return 'user_not_created';
      //   }
      // });
    });
  }
}

final RegisterService registerService = RegisterService();
