import 'package:kurs3_sabak9/models/chat_model.dart';
import 'package:kurs3_sabak9/utilities/firestore_collections/firestore_collections.dart';

class ChatServices {
  Stream<List<ChatModel>> streamChat() {
    return FirestoreCollections.chatReference
        .orderBy('created_at', descending: false)
        .snapshots()
        .map((document) {
      return document.docs.map((data) {
        return ChatModel.fromJson(data.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}

final ChatServices chatServices = ChatServices();
