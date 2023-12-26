import 'package:flutter/material.dart';
import 'package:sbpos/database/database_instance.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:sqflite/sqflite.dart';

class LoginProvider extends ChangeNotifier {
  Map<String, dynamic> matel = {
    'idUser': 'matel',
    'password': '123123',
  };

  String? user;
  String? pass;

  TextEditingController cIdUser = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  DatabaseInstance dbInstance = DatabaseInstance.instance;

  void login(context) async {
    bool bypassMatel = bypass();
    String tempIdUser = cIdUser.text;
    String tempPassword = cPassword.text;
    if (bypassMatel) {
      debugPrint('navigator ke menu utama');
      Navigator.pushReplacementNamed(context, '/menu');
      user = 'Matel';
      clearForm();
    } else {
      Database db = await dbInstance.database();
      var query =
          'SELECT user,password FROM users WHERE user = "${cIdUser.text}"';
      List<Map<String, dynamic>> response = await db.rawQuery(query);
      if (response.isNotEmpty) {
        user = response[0]['user'];
        pass = response[0]['password'];
      }
      if (tempIdUser == user && tempPassword == pass) {
        Navigator.pushReplacementNamed(context, '/menu');
        clearForm();
        customSnackbar(
          context,
          'Success Login into SB Pos!',
          Colors.green,
          const Duration(seconds: 3),
        );
      } else {
        customSnackbar(
          context,
          'Username atau password Salah',
          Colors.yellow,
          const Duration(seconds: 3),
        );
      }
    }

    /// - pengecekan id user dan password ke database,
    /// - jika ditemukan matel makan arahkan ke halaman menu utama dan dibuka menu semua
    /// - jika ditemukan id user yang telah didaftarkan maka arahkan ke halaman menu utama dan sesuaikan
    /// dengan jabatan yang telah di atur.
    /// - jika tidak ditemukan maka clear textfield dan berikan notif bahwa id user tidak ditemukan
    /// atau password salah
    /// - clear halaman sebelumnya dan masuk ke arah halaman menu utama
  }

  bool bypass() {
    String idMatel = matel['idUser'];
    String passMatel = matel['password'];
    if (cIdUser.text == idMatel && cPassword.text == passMatel) {
      debugPrint('login dengan id matel dan redirect ke menu utama');
      return true;
    } else {
      return false;
    }
  }

  clearForm() {
    cIdUser.clear();
    cPassword.clear();
  }
}
