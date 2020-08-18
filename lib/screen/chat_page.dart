import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';

class ChatPage extends StatefulWidget {
  final String uuid;
  final String username;

  ChatPage({this.uuid, this.username});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatUser user = ChatUser();


  @override
  void initState() {
    user.name = widget.username;
    user.uid = widget.uuid;
    super.initState();
  }

  void onSend(ChatMessage message) {

  }

  void uploadFile() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff21254A),
      body: StreamBuilder(
        *//*stream: ,*//*
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          } else {
            return DashChat(
              messages: new ChatMessage(text: "dada", ),
              user: null,
              onSend: onSend,
              inputDecoration: InputDecoration(
                hintText: "Message here...",
                border: InputBorder.none,
                ),
              trailing: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: uploadFile,
                )
              ],
            );
          }
        }
      ),*/
    );
  }
}
