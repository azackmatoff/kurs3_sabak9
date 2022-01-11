import 'dart:developer';

class ChatModel {
  ChatModel({
    this.text,
    this.senderID,
    this.senderEmail,
  });

  factory ChatModel.fromJson(Map<String, Object> json) {
    log('ChatModel.fromJson json ===>> $json');
    return ChatModel(
      text: json['text'] as String,
      senderEmail: json['senderEmail'] as String,
      senderID: json['senderID'] as String,
    );
  }

  final String text;
  final String senderID;
  final String senderEmail;

  Map<String, Object> toJson() {
    return {
      'text': text,
      'senderID': senderID,
      'senderEmail': senderEmail,
    };
  }
}
