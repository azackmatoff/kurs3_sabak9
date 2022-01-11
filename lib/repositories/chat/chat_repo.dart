import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/models/chat_model.dart';
import 'package:kurs3_sabak9/models/user_model.dart';
import 'package:kurs3_sabak9/services/authentication/auth_services.dart';
import 'package:kurs3_sabak9/services/chat/chat_services.dart';
import 'package:kurs3_sabak9/utilities/app_utils/dialogs/error_dialog_util.dart';
import 'package:kurs3_sabak9/utilities/firestore_collections/firestore_collections.dart';

class ChatRepo {
  Future<void> signOut(BuildContext context) async {
    final _isSignedOut = await authServices.signOut();

    if (!_isSignedOut) {
      ErrorDialogUtil.showErrorDialog(
          context, 'Something went wrong, please try again!');
    }
  }

  Future<void> sendChat(
    BuildContext context,
    String messageText,
    UserModel userModel,
  ) async {
    final _data = await FirestoreCollections.chatReference.add({
      'text': messageText,
      'senderID': userModel.userId,
      'senderEmail': userModel.email,
      'created_at': FieldValue.serverTimestamp(),
    });

    if (_data == null) {
      ErrorDialogUtil.showErrorDialog(context, 'Something went wrong!');
    }
  }

  Stream<List<ChatModel>> streamChat() {
    return chatServices.streamChat();
  }
}

final ChatRepo chatRepo = ChatRepo();
