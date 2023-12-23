import 'package:flutter/material.dart';
import 'package:sbpos/database/database_instance.dart';
import 'package:sbpos/models/level_model.dart';
import 'package:sbpos/models/user_model.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:sqflite/sqflite.dart';

class UsersProvider extends ChangeNotifier {
  int? idUser;
  String? user;
  String? password;
  int? idLevel;
  List users = [];
  List level = [];
  List permission = ['0', '0', '0', '0', '0', '0'];
  bool? isChecked = false;

  List menu = ['sell', 'data stock', 'buy', 'report', 'users', 'setting'];

  UsersProvider({this.user, this.password});

  TextEditingController cUser = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cRetypePassword = TextEditingController();
  TextEditingController cLevel = TextEditingController();
  TextEditingController cPermission = TextEditingController();

  DatabaseInstance dbInstance = DatabaseInstance.instance;

  bool validation() {
    String password = cPassword.text;
    String retypePassword = cRetypePassword.text;
    if (password == retypePassword &&
        cUser.text.isNotEmpty &&
        cPassword.text.isNotEmpty &&
        cLevel.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  resetPermission() {
    permission.remove('');
    permission = ['0', '0', '0', '0', '0', '0'];
    notifyListeners();
  }

  changeCheckbox(bool val, index) {
    if (val) {
      permission[index] = '1';
    } else {
      permission[index] = '0';
    }

    notifyListeners();
    debugPrint(permission.toString());
  }

  clearTextField() {
    cUser.clear();
    cPassword.clear();
    cRetypePassword.clear();
    cLevel.clear();
    idLevel = 0;
  }

  getUsers() async {
    Database db = await dbInstance.database();
    var query =
        'SELECT id,user,password,level.id_level,level.level,users.create_at,users.update_at FROM users INNER JOIN level ON users.level = level.id_level';
    // var query = 'SELECT * FROM level';
    List<Map<String, dynamic>> result = await db.rawQuery(query);
    //debugPrint(result.toString());

    users.clear();
    for (var r in result) {
      users.add(UserModel(
        id: r['id'],
        user: r['user'],
        password: r['password'],
        idLevel: r['id_level'],
        level: r['level'],
        createAt: r['create_at'],
        updateAt: r['update_at'],
      ));
    }

    notifyListeners();
  }

  getUserById() async {
    //
  }

  addUser(context) async {
    bool validatePassword = validation();
    user = cUser.text.toUpperCase();
    password = cPassword.text;

    if (validatePassword) {
      try {
        Database db = await dbInstance.database();
        var query =
            'INSERT INTO users (user,password,level) VALUES ("$user","$password",$idLevel)';
        await db.rawInsert(query);

        customSnackbar(
          context,
          'Sucess add new user : $user',
          Colors.green,
          const Duration(seconds: 2),
        );
        getUsers();
        notifyListeners();
        Navigator.pop(context);
      } catch (e) {
        customSnackbar(
          context,
          '$user is exist please chose other',
          Colors.red,
          const Duration(seconds: 2),
        );
      }
    } else {
      if (cUser.text.isEmpty && cPassword.text.isEmpty) {
        customSnackbar(
          context,
          'Please fill user, password and level',
          Colors.red,
          const Duration(seconds: 2),
        );
      } else if (cLevel.text.isEmpty) {
        customSnackbar(
          context,
          'Please select Level',
          Colors.red,
          const Duration(seconds: 2),
        );
      } else {
        customSnackbar(
          context,
          'password and retype password wrong!',
          Colors.red,
          const Duration(seconds: 2),
        );
      }
    }
  }

  updateUser(BuildContext context) async {
    bool validatePassword = validation();
    user = cUser.text.toUpperCase();
    password = cPassword.text;

    if (validatePassword) {
      try {
        Database db = await dbInstance.database();
        var query =
            'UPDATE users SET user = "$user", password = "$password", level = "$idLevel", update_at=CURRENT_TIMESTAMP WHERE id = $idUser';
        await db.rawUpdate(query);
        // ignore: use_build_context_synchronously
        if (!context.mounted) return;
        customSnackbar(
          context,
          'Sucess Update user : $user',
          Colors.green,
          const Duration(seconds: 2),
        );
        getUsers();
        notifyListeners();
        Navigator.pop(context);
      } catch (e) {
        customSnackbar(
          context,
          '$user is exist please chose other',
          Colors.red,
          const Duration(seconds: 2),
        );
      }
    } else {
      if (cUser.text.isEmpty && cPassword.text.isEmpty) {
        customSnackbar(
          context,
          'Please fill user, password and level',
          Colors.red,
          const Duration(seconds: 2),
        );
      } else if (cLevel.text.isEmpty) {
        customSnackbar(
          context,
          'Please select Level',
          Colors.red,
          const Duration(seconds: 2),
        );
      } else {
        customSnackbar(
          context,
          'password and retype password wrong!',
          Colors.red,
          const Duration(seconds: 2),
        );
      }
    }
  }

  deleteUser(BuildContext context, int id) async {
    try {
      Database db = await dbInstance.database();
      var query = 'DELETE FROM users WHERE id = $id';
      await db.rawDelete(query);
      notifyListeners();
      // ignore: use_build_context_synchronously
      if (!context.mounted) return;
      customSnackbar(
        context,
        'Success Delete data!',
        Colors.red,
        const Duration(seconds: 2),
      );
    } catch (e) {
      customSnackbar(
        context,
        'Error Delete',
        Colors.red,
        const Duration(seconds: 2),
      );
    }
  }

  // function level
  addLevel(String level, String permission) async {
    Database db = await dbInstance.database();
    var query =
        'INSERT INTO level (level,permission) VALUES ("$level","$permission")';

    await db.rawInsert(query);
    debugPrint(query.toString());
    resetPermission();
    notifyListeners();
  }

  updateLevel(int id, String level, String permission) async {
    Database db = await dbInstance.database();
    var query =
        'UPDATE level SET level = "$level", permission = "$permission" WHERE id_level = $id';

    int count = await db.rawUpdate(query);
    debugPrint(count.toString());
    debugPrint(query.toString());
    resetPermission();
    notifyListeners();
  }

  getLevel() async {
    Database db = await dbInstance.database();
    var query = 'SELECT id_level,level,permission FROM level';
    List<Map<String, dynamic>> response = await db.rawQuery(query);
    level.clear();
    for (var l in response) {
      level.add(
        LevelModel(
            idLevel: l['id_level'],
            level: l['level'],
            permission: l['permission']),
      );
    }
    debugPrint(response.toString());
    notifyListeners();
  }

  getLevelById(int id) async {
    Database db = await dbInstance.database();
    var query =
        'SELECT id_level,level,permission FROM level WHERE id_level = $id';
    var response = await db.rawQuery(query);

    debugPrint(response.toString());

    List getPermission = response[0]['permission'].toString().split('');

    permission.remove('');

    permission = getPermission;

    notifyListeners();
  }

  deleteLevel() async {
    Database db = await dbInstance.database();
    var query = 'DELETE FROM level';
    db.rawDelete(query);
  }
}
