import 'package:anonapp_mobile/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SocketMessage {
  final MessageType type;
  final SocketChatMessage chatMessage;

  SocketMessage(this.type, this.chatMessage);

  factory SocketMessage.fromJson(Map<String, dynamic> json) => _$SocketMessageFromJson(json);
  Map<String, dynamic> toJson() => _$SocketMessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SocketChatMessage {
  final String id;
  final String text;
  final SocketChatUser user;
  final String image;
  final String video;

  SocketChatMessage(this.id, this.text, this.user, this.image, this.video);

  factory SocketChatMessage.fromJson(Map<String, dynamic> json) => _$SocketChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$SocketChatMessageToJson(this);
}

enum MessageType {
  MSG,
  NEXT,
  LIKE,
  CONNECT
}