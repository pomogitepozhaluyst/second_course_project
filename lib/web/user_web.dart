import 'package:json_annotation/json_annotation.dart';

part 'user_web.g.dart';

@JsonSerializable()
class UserWeb {
  @JsonKey(name: 'auth_token')
  String token = '';
  int exp = 0;
  int level = 0;
  String name = '';
  int needExpToNextLevel = 10;

  UserWeb({
    required this.token,
    required name,
    required this.level,
    required this.exp,
    required this.needExpToNextLevel,
  }) {
    if (name == null) {
      this.name = "";
    } else {
      this.name = name;
    }
  }

  factory UserWeb.fromJson(Map<String, dynamic> json) => _$UserWebFromJson(json);

  Map<String, dynamic> toJson() => _$UserWebToJson(this);
}
