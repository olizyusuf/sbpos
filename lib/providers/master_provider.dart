import 'package:flutter/material.dart';
import 'package:sbpos/database/database_instance.dart';
import 'package:sbpos/models/kategori_model.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:sqflite/sqflite.dart';

class MasterProvider extends ChangeNotifier {
  List masters = [];

  List kategori = [];

  TextEditingController cKodeBarang = TextEditingController();
  TextEditingController cBarcode = TextEditingController();
  TextEditingController cNama = TextEditingController();
  TextEditingController cStock = TextEditingController();
  TextEditingController cSatuan = TextEditingController();
  TextEditingController cHargaBeli = TextEditingController();
  TextEditingController cHargaJual = TextEditingController();

  TextEditingController cIdKategori = TextEditingController();
  TextEditingController cNamaKategori = TextEditingController();

  DatabaseInstance dbInstance = DatabaseInstance.instance;

  getMaster() {
// todo here
  }

  addMaster() {
// todo here
  }

  updateMaster() {
// todo here
  }

  deleteMaster() {
// todo here
  }

  getKategori() async {
    Database db = await dbInstance.database();
    var query = 'SELECT * FROM kategori';
    List<Map<String, dynamic>> response = await db.rawQuery(query);

    kategori.clear();
    for (var r in response) {
      kategori.add(KategoriModel(
          idKategori: r['id_kategori'],
          nama: r['nama'],
          createAt: r['create_at'],
          updateAt: r['update_at']));
    }

    notifyListeners();
  }

  getKategoriById(int id) async {
    Database db = await dbInstance.database();
    var query = 'SELECT * FROM kategori WHERE id_kategori = $id';
    List<Map<String, dynamic>> response = await db.rawQuery(query);

    if (response.isNotEmpty) {
      cNamaKategori.text = response[0]['nama'].toString();
    }

    notifyListeners();
  }

  addKategori(context) async {
    String namaKategori = cNamaKategori.text;
    if (namaKategori.isNotEmpty) {
      try {
        Database db = await dbInstance.database();
        var query =
            'INSERT INTO kategori(nama) VALUES("${namaKategori.toUpperCase()}")';
        await db.rawInsert(query);

        cNamaKategori.clear();
        FocusScope.of(context).unfocus();

        customSnackbar(context, 'Kategori berhasil disimpan!', Colors.green,
            const Duration(seconds: 2));
      } catch (e) {
        customSnackbar(context, 'Kategori telah ada!', Colors.red,
            const Duration(seconds: 2));
      }
    } else {
      customSnackbar(
          context, 'Kategori Kosong!', Colors.red, const Duration(seconds: 2));
    }
    notifyListeners();
  }

  updateKategori(context, int id) async {
    try {
      String namaKategori = cNamaKategori.text;

      Database db = await dbInstance.database();
      var query =
          'UPDATE kategori SET nama="${namaKategori.toUpperCase()}", update_at=CURRENT_TIMESTAMP WHERE id_kategori = $id';
      await db.rawUpdate(query);
      customSnackbar(context, 'Kategori berhasil diubah!', Colors.green,
          const Duration(seconds: 2));
    } catch (e) {
      debugPrint(e.toString());
      customSnackbar(context, 'Kategori telah ada, gagal diubah.', Colors.red,
          const Duration(seconds: 2));
    }
    getKategori();
    notifyListeners();
  }

  deleteKategori(context, int id) async {
    try {
      Database db = await dbInstance.database();
      var query = 'DELETE FROM kategori WHERE id_kategori = $id';
      await db.rawDelete(query);
      customSnackbar(context, 'Kategori berhasil berhasil dihapus!',
          Colors.green, const Duration(seconds: 2));
    } catch (e) {
      customSnackbar(
          context,
          'kategori tidak bisa dihapus sebelum data barang dihapus.',
          Colors.red,
          const Duration(seconds: 2));
    }
    getKategori();
    notifyListeners();
  }
}
