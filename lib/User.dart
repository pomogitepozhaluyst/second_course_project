class User {
  int id = 0;
  int exp = 0;
  int level = 0;
  String name = "";
  int needExpToNextLevel = 100;
  late String password;
  User(
      {required this.id,
      required this.name,
      required this.level,
      required this.exp,
      required this.needExpToNextLevel,
      required this.password});
}
