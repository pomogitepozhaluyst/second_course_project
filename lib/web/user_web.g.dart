// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_web.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWeb _$UserWebFromJson(Map<String, dynamic> json) {
  return UserWeb(
    token: json['auth_token'] as String,
    name: json['name'],
    level: json['level'] as int,
    exp: json['exp'] as int,
    needExpToNextLevel: json['needExpToNextLevel'] as int,
  );
}

Map<String, dynamic> _$UserWebToJson(UserWeb instance) => <String, dynamic>{
      'auth_token': instance.token,
      'exp': instance.exp,
      'level': instance.level,
      'name': instance.name,
      'needExpToNextLevel': instance.needExpToNextLevel,
    };
