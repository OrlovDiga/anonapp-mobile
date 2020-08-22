// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocketMessage _$SocketMessageFromJson(Map<String, dynamic> json) {
  return SocketMessage(
    _$enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
    json['chatMessage'] == null
        ? null
        : SocketChatMessage.fromJson(
            json['chatMessage'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SocketMessageToJson(SocketMessage instance) =>
    <String, dynamic>{
      'type': _$MessageTypeEnumMap[instance.type],
      'chatMessage': instance.chatMessage?.toJson(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$MessageTypeEnumMap = {
  MessageType.MSG: 'MSG',
  MessageType.NEXT: 'NEXT',
  MessageType.LIKE: 'LIKE',
  MessageType.CONNECT: 'CONNECT',
};

SocketChatMessage _$SocketChatMessageFromJson(Map<String, dynamic> json) {
  return SocketChatMessage(
    json['id'] as String,
    json['text'] as String,
    json['user'] == null
        ? null
        : SocketChatUser.fromJson(json['user'] as Map<String, dynamic>),
    json['image'] as String,
    json['video'] as String,
  );
}

Map<String, dynamic> _$SocketChatMessageToJson(SocketChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'user': instance.user?.toJson(),
      'image': instance.image,
      'video': instance.video,
    };

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
