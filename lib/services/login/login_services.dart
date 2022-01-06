import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kurs3_sabak9/utilities/firestore_collections/firestore_collections.dart';

class LoginServices {
  Future<DocumentSnapshot> getUser(String userId) async {
    try {
      return await FirestoreCollections.userReference.doc(userId).get();
    } catch (e) {
      throw Exception(e);
    }
  }
}

final LoginServices loginServices = LoginServices();
