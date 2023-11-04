import 'package:flutter/material.dart';
import 'package:sbpos/database/database_instance.dart';
import 'package:sbpos/models/kategori_model.dart';
import 'package:sbpos/models/master_model.dart';
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

  void getKategori() async {
    Database db = await dbInstance.database();
    var query = 'SELECT * FROM kategori';
    List<Map<String, dynamic>> response = await db.rawQuery(query);
    debugPrint(response.toString());

    kategori.clear();
    for (var r in response) {
      kategori.add(KategoriModel(
          idKategori: r['id_kategori'],
          nama: r['nama'],
          createAt: r['create_at'],
          updateAt: r['update_at']));
    }
  }

  void addKategori() async {
    Database db = await dbInstance.database();
    var query = 'INSERT INTO kategori(nama) VALUES("MAKANAN")';
    var response = await db.rawInsert(query);
    debugPrint(response.toString());
  }

  updateKategori() {
// todo here
  }
}
