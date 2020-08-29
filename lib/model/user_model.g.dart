// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocketChatUser _$SocketChatUserFromJson(Map<String, dynamic> json) {
  return SocketChatUser(
    json['uid'] as String,
    json['name'] as String,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$SocketChatUserToJson(SocketChatUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'avatar': instance.avatar,
    };
