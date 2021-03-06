import 'dart:async';
import 'dart:convert';

import 'package:anonapp_mobile/model/message_model.dart';
import 'package:anonapp_mobile/model/user_model.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:swipedetector/swipedetector.dart';
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget {
  final token;
  IOWebSocketChannel channel;

  ChatPage(this.token);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    widget.channel = IOWebSocketChannel.connect(
    Uri(scheme: "ws", host: "localhost", port: 8080, path: "/api/socket"),
    headers: {'token': widget.token}
    );
        super.initState();
  }

  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  bool _showChat = true;
  Color _heartColor;
  Color _photoColor = Colors.grey;
  bool _isHeartButtonDisabled = true;
  bool _isNextButtonDisabled = true;
  bool _canUploadFile = false;
  final picker = new ImagePicker();

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
    SocketChatUser user = new SocketChatUser('uid', "Walf", "urlToAvatar");
    SocketChatMessage chatMessage = new SocketChatMessage(message.id, message.text, user, message.image, message.video);
    SocketMessage msg = new SocketMessage(MessageType.MSG, chatMessage);
    print(message.toJson());
    messages.add(message);
    widget.channel.sink.add(jsonEncode(msg.toJson()));
    print(jsonEncode(msg.toJson()));
  }

  void uploadFile() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    final bytes = await pickedFile.readAsBytes();

    String data = base64.encode(bytes);
    String fileExtension = path.extension(pickedFile.path);

    var url = "http://127.0.0.1:8080/resources";
    Map jsonData = {
      'extension': fileExtension,
      'data': data
    };

    var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(jsonData),
    );

    ChatMessage message =
    ChatMessage(text: "", user: user, image: response.body.toString());
    messages.add(message);
  }

  @override
  void didUpdateWidget(ChatPage oldWidget) {
    super.didUpdateWidget(oldWidget);
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
                  onPressed: _isNextButtonDisabled ? null : onPressedToNext,
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

                if (!snapshots.hasData/*false*/) {
                  print('Haven\'t data.');
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                } else {
                  SocketMessage socketMessage = SocketMessage.fromJson(jsonDecode(snapshots.data));
                  //SocketMessage socketMessage = SocketMessage(MessageType.CONNECT, null);
                  print('in stream _showChat =  ${_showChat}');
                  if (socketMessage.type == MessageType.CONNECT) {
                    _isNextButtonDisabled = false;
                    _isHeartButtonDisabled = false;
                    _showChat = true;
                    print('Start chat!');
                  } else if (!_showChat) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  } else if (socketMessage.type == MessageType.LIKE) {
                    _canUploadFile = true;
                    _photoColor = Colors.black;
                  } else if (socketMessage.type == MessageType.MSG) {
                    SocketChatMessage msg = socketMessage.chatMessage;
                    ChatUser user = new ChatUser();
                    user.uid = msg.user.uid;
                    user.name = msg.user.name;
                    user.avatar = msg.user.avatar;
                    ChatMessage message = new ChatMessage(text: msg.text, user: user, image: msg.image, video: msg.video, id: msg.id);
                    messages.add(message);
                  }  else if (socketMessage.type == MessageType.NEXT) {
                    //print('Start chat!');
                    _showChat = false;
                    refreshPage();
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }

                  //var items = List();
                  //String s = snapshots.data.toString();
                  //ChatMessage msg = new ChatMessage(text: "Hello,World!", user: otherUser);
                  //messages.add(msg);
                  //items.add(s);
                  //var messages =
                  //items.map((i) => new ChatMessage(text: i, user: otherUser)).toList();
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
                    onLoadEarlier: () {
                      print("laoding...");
                    },
                    leading: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.photo,
                          color: _photoColor,
                        ),
                        onPressed: _canUploadFile ? uploadFile : null,
                      ),
                    ],
                    shouldShowLoadEarlier: false,
                    showTraillingBeforeSend: true,
                  );
                }
              }
          ),
        ),
      onSwipeLeft: () {
          onPressedToNext();
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
      _heartColor = Colors.red;
    });
  }

  void onPressedToBack() {
      widget.channel.sink.close();
      Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
  }

  void onPressedToNext() {
    SocketMessage msg = new SocketMessage(MessageType.NEXT, null);
    print(json.encode(msg));
    widget.channel.sink.add(json.encode(msg));
    print('Before in onPressedToNext _showChat =  ${_showChat}');
    _showChat = false;
    print('After in onPressedToNext _showChat =  ${_showChat}');
    refreshPage();
  }

  void refreshPage() {
    messages.clear();
    _heartColor = null;
    _photoColor = Colors.grey;
    _isHeartButtonDisabled = false;
    _canUploadFile = false;
    setState(() {});
  }
}


