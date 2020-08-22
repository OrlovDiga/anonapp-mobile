import 'dart:async';
import 'dart:io';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:swipedetector/swipedetector.dart';


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
  Color _heartColor;
  Color _photoColor = Colors.grey;
  bool _isHeartButtonDisabled = false;
  bool _canUploadFile = false;

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

  List<ChatMessage> messageList = List<ChatMessage>();
  var m = List<ChatMessage>();

  var i = 0;

  @override
  void initState() {
    super.initState();
  }

  void onSend(ChatMessage message) {
    print(message.toJson());
    //messageList.add(message);
    widget.channel.sink.add(message.toJson().toString());
  }

  void uploadFile() async {

  }

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
        child: Scaffold(
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
                  onPressed: _isHeartButtonDisabled ? null : onPressedToHeart,
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
                  //var messages =
                  //items.map((i) => new ChatMessage(text: i, user: otherUser)).toList();
                  return DashChat(
                    user: user,
                    messages: messageList,
                    sendOnEnter: true,
                    inputDecoration: InputDecoration(
                      hintText: "Message here...",
                      border: InputBorder.none,
                    ),
                    onSend: onSend,
                    leading: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.photo,
                          color: _photoColor,
                        ),
                        onPressed: _canUploadFile ? uploadFile : null,
                      ),
                    ],
                    showTraillingBeforeSend: false,
                  );
                }
              }
          ),
        ),
      onSwipeLeft: () {
        Navigator.pushNamedAndRemoveUntil(context, '/chat', (route) => false);
      },
      swipeConfiguration: SwipeConfiguration(
          verticalSwipeMinVelocity: 100.0,
          verticalSwipeMinDisplacement: 50.0,
          verticalSwipeMaxWidthThreshold:100.0,
          horizontalSwipeMaxHeightThreshold: 50.0,
          horizontalSwipeMinDisplacement:50.0,
          horizontalSwipeMinVelocity: 200.0
      ),
    );
  }

  void onPressedToHeart() {
    setState(() {
      _isHeartButtonDisabled = true;
      _canUploadFile = true;
      _heartColor = Colors.red;
      _photoColor = Colors.black;
    });
  }

  void onPressedToBack() {
      widget.channel.sink.close();
      Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
  }

  void onPressedToNext() {
    Navigator.pushNamedAndRemoveUntil(context, "/chat", (r) => false);
  }
}


