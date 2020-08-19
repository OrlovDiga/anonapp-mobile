import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';
import 'dart:async';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';


class ChatPage extends StatefulWidget {
  final String uuid;
  final String username;
  IOWebSocketChannel channel = IOWebSocketChannel.connect(
      Uri(scheme: "ws", host: "localhost", port: 8080, path: "/api/socket"),
      headers: {'token': File('/Users/macbook/AndroidStudioProjects/anonapp_mobile/assets/config/token').readAsStringSync()}
  );

/*  IOWebSocketChannel channel = new IOWebSocketChannel.connect(
      Uri(scheme: "ws", host: "localhost", port: 8080, path: "/api/socket"),
      headers: {'token': token}
  );*/

  //ChatPage(this.uuid, this.username, this.channel);



  //final token = getToken();
  ChatPage({this.uuid, this.username});

  IOWebSocketChannel getWebSocketConnect() {
    String token = File('/Users/macbook/AndroidStudioProjects/anonapp_mobile/assets/config/token').readAsStringSync();
    return IOWebSocketChannel.connect(
        Uri(scheme: "ws", host: "localhost", port: 8080, path: "/api/socket"),
        headers: {'token': token}
    );
  }

  @override
  _ChatPageState createState() => _ChatPageState();

}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

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
  var m = List<ChatMessage>();

  var i = 0;

  @override
  void initState() {
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
    widget.channel.sink.add(message.text);


  }

  void uploadFile() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff21254A),
      body: StreamBuilder(
        stream: widget.channel.stream,
        builder: (context, snapshots) {
          var counter = 1;
          if (false) {
            counter++;
            print('Time passed: ${counter}');
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          } else {
            return DashChat(
              key: _chatViewKey,
              inverted: false,
              onSend: onSend,
              sendOnEnter: true,
              textInputAction: TextInputAction.send,
              user: user,
              inputDecoration:
              InputDecoration.collapsed(hintText: "Add message here..."),
              dateFormat: DateFormat('yyyy-MMM-dd'),
              timeFormat: DateFormat('HH:mm'),
              messages: messages,
              showUserAvatar: false,
              showAvatarForEveryMessage: false,
              scrollToBottom: true,
              onPressAvatar: (ChatUser user) {
                print("OnPressAvatar: ${user.name}");
              },
              onLongPressAvatar: (ChatUser user) {
                print("OnLongPressAvatar: ${user.name}");
              },
              inputMaxLines: 5,
              messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
              alwaysShowSend: true,
              inputTextStyle: TextStyle(fontSize: 16.0),
              inputContainerStyle: BoxDecoration(
                border: Border.all(width: 0.0),
                color: Colors.white,
              ),
              onQuickReply: (Reply reply) {
                setState(() {
                  messages.add(ChatMessage(
                      text: reply.value,
                      createdAt: DateTime.now(),
                      user: user));

                  messages = [...messages];
                });

                Timer(Duration(milliseconds: 300), () {
                  _chatViewKey.currentState.scrollController
                    ..animateTo(
                      _chatViewKey.currentState.scrollController.position
                          .maxScrollExtent,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );

                  if (i == 0) {
                    systemMessage();
                    Timer(Duration(milliseconds: 600), () {
                      systemMessage();
                    });
                  } else {
                    systemMessage();
                  }
                });
              },
              onLoadEarlier: () {
                print("laoding...");
              },
              shouldShowLoadEarlier: false,
              showTraillingBeforeSend: true,

            );
          }
        }
      ),
    );
  }
}
