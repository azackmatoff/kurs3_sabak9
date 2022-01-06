import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollections {
  static FirestoreCollections _storageUtil;
  static FirebaseFirestore _firestore;

  static FirestoreCollections getInstance() {
    if (_storageUtil == null) {
      final storageUtil = FirestoreCollections._();
      storageUtil._init();
      _storageUtil = storageUtil;
    }
    return _storageUtil;
  }

  FirestoreCollections._();

  void _init() {
    _firestore = FirebaseFirestore.instance;
  }

  static final CollectionReference userReference =
      _firestore.collection('users');

  static final CollectionReference chatReference =
      _firestore.collection('chats');
}
