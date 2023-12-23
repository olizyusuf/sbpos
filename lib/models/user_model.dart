class UserModel {
  int? id;
  String? user;
  String? password;
  int? idLevel;
  String? level;
  String? createAt;
  String? updateAt;

  UserModel(
      {this.id,
      this.user,
      this.password,
      this.idLevel,
      this.level,
      this.createAt,
      this.updateAt});
}
