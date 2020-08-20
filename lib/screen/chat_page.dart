import 'dart:async';
import 'dart:io';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';


class ChatPage extends StatefulWidget {
  final IOWebSocketChannel channel = IOWebSocketChannel.connect(
      Uri(scheme: "ws", host: "localhost", port: 8080, path: "/api/socket"),
      headers: {'token': File('/Users/macbook/AndroidStudioProjects/anonapp_mobile/assets/config/token').readAsStringSync()}
  );

  @override
  _ChatPageState createState() => _ChatPageState();

}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  //ScrollController _controller;
  Color _heartColor;

  final ChatUser user = ChatUser(
    name: "Fayeed",
    firstName: "Fayeed",
    lastName: "Pawaskar",
    uid: "12345678",
    avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
  );

  final ChatUser otherUser = ChatUser(
    name: "Mrfatty",
    uid: "25649654",
  );

  List<ChatMessage> messages = List<ChatMessage>();
  List<ChatMessage> messageList = List<ChatMessage>();
  var m = List<ChatMessage>();

  var i = 0;

  @override
  void initState() {
   // _controller = ScrollController();
    super.initState();
  }


  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  void onSend(ChatMessage message) {
    print(message.toJson());
    messageList.add(message);
    widget.channel.sink.add(message.toJson().toString());
  }

  void uploadFile() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:  CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 35.0,
              ),
              onPressed: onPressedToBack,
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: _heartColor,
                size: 35,
              ),
              onPressed: onPressedToHeart,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 110),
            ),
            IconButton(
              icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 35
              ),
              onPressed: onPressedToNext,
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(131, 58, 199, 15),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff21254A),
      body: StreamBuilder(
        stream: widget.channel.stream,
        builder: (context, snapshots) {
          print('${snapshots.toString()}');
          print('${snapshots.data.toString()}');
          if (/*!snapshots.hasData*/false) {
            print('Haven\'t data.');
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          } else {
            var items = List();
            String s = snapshots.data.toString();
            ChatMessage msg = new ChatMessage(text: s, user: otherUser);
            messageList.add(msg);
            //items.add(s);
           /* var messages =
            items.map((i) => new ChatMessage(text: i, user: otherUser)).toList();*/
            return DashChat(
              user: user,
              messages: messageList,
              sendOnEnter: true,
              inputDecoration: InputDecoration(
                hintText: "Message here...",
                border: InputBorder.none,
              ),
              onSend: onSend,
             //scrollController: _controller,
              trailing: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: uploadFile,
                )
              ],
            );
          }
        }
      ),
    );
  }

  void onPressedToHeart() {
    setState(() {
      if (_heartColor == Colors.red) {
        _heartColor = Colors.white;
      } else {
        _heartColor = Colors.red;
      }
    });
  }

  void onPressedToBack() {
      widget.channel.sink.close();
      Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
  }

  void onPressedToNext() {

  }
}
