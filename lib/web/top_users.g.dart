// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopUsers _$TopUsersFromJson(Map<String, dynamic> json) {
  return TopUsers(
    name: json['name'],
    level: json['level'] as int,
  );
}

Map<String, dynamic> _$TopUsersToJson(TopUsers instance) => <String, dynamic>{
      'name': instance.name,
      'level': instance.level,
    };
