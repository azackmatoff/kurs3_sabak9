import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/models/chat_model.dart';
import 'package:kurs3_sabak9/repositories/chat/chat_repo.dart';
import 'package:kurs3_sabak9/widgets/chats/message_bubble.dart';

class MessagesStreamWidget extends StatelessWidget {
  final String currentUserID;

  const MessagesStreamWidget({Key key, @required this.currentUserID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatModel>>(
      stream: chatRepo.streamChat(),
      builder: (BuildContext context, AsyncSnapshot<List<ChatModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        } else if (snapshot.hasData) {
          final chats = snapshot.data.reversed;
          List<MessageBubble> messageBubbles = <MessageBubble>[];

          for (var chat in chats) {
            final messageBubble = MessageBubble(
              sednerID: chat.senderID,
              senderEmail: chat.senderEmail,
              text: chat.text,
              isMe: currentUserID == chat.senderID,
            );

            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
