import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

class User {
  final int id;
  final String name;
  final String password;
  final String matchingPassword;

  User(this.id, this.name, this.password, this.matchingPassword);
}

@JsonSerializable()
class SocketChatUser {
  final String uid;
  final String name;
  final String avatar;

  SocketChatUser(this.uid, this.name, this.avatar);

  factory SocketChatUser.fromJson(Map<String, dynamic> json) => _$SocketChatUserFromJson(json);
  Map<String, dynamic> toJson() => _$SocketChatUserToJson(this);
}