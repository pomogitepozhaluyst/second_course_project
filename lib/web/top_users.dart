import 'package:json_annotation/json_annotation.dart';

part 'top_users.g.dart';

@JsonSerializable()
class TopUsers {
  String name = '';
  int level = 0;

  TopUsers({
    required name,
    required this.level,
  }) {
    if (name == null) {
      this.name = 'Анонимный пользователь';
    } else {
      this.name = name;
    }
  }

  factory TopUsers.fromJson(Map<String, dynamic> json) => _$TopUsersFromJson(json);

  Map<String, dynamic> toJson() => _$TopUsersToJson(this);
}
