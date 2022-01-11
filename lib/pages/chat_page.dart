import 'package:flutter/material.dart';
import 'package:kurs3_sabak9/app_constants/app_constants.dart';
import 'package:kurs3_sabak9/app_constants/constants.dart';

import 'package:kurs3_sabak9/models/user_model.dart';
import 'package:kurs3_sabak9/pages/home_page.dart';
import 'package:kurs3_sabak9/repositories/chat/chat_repo.dart';

import 'package:kurs3_sabak9/widgets/chats/message_stream_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    @required this.userModel,
    Key key,
  }) : super(key: key);

  static const String id = AppConstants.chat;

  final UserModel userModel;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageTextController = TextEditingController();
  String messageText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await chatRepo.signOut(context);
                Navigator.pushNamed(context, HomePage.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStreamWidget(
              currentUserID: widget.userModel.userId,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      messageTextController.clear();

                      await chatRepo.sendChat(
                          context, messageText, widget.userModel);
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
