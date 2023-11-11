import 'package:flutter/material.dart';
import 'package:sbpos/database/database_instance.dart';
import 'package:sbpos/models/kategori_model.dart';
import 'package:sbpos/models/master_model.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:sqflite/sqflite.dart';

class MasterProvider extends ChangeNotifier {
  int? idKategori;

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

  clearText() {
    cKodeBarang.clear();
    cBarcode.clear();
    cNama.clear();
    cStock.clear();
    cSatuan.clear();
    cHargaBeli.clear();
    cHargaJual.clear();
    cNamaKategori.clear();
    idKategori = 0;
  }

  getMaster() async {
    Database db = await dbInstance.database();
    var query = 'SELECT * FROM master';
    List<Map<String, dynamic>> response = await db.rawQuery(query);

    masters.clear();
    for (var r in response) {
      masters.add(MasterModel(
          kodeBarang: r['kd_barang'],
          barcode: r['barcode'],
          nama: r['nama'],
          stock: r['stock'],
          satuan: r['satuan'],
          hargaBeli: r['h_beli'],
          hargaJual: r['h_jual'],
          idKategori: r['kategori'],
          createAt: r['create_at'],
          updateAt: r['update_at']));
    }

    notifyListeners();
  }

  addMaster(context) async {
    if (cKodeBarang.text.isNotEmpty &&
        cBarcode.text.isNotEmpty &&
        cNama.text.isNotEmpty &&
        cStock.text.isNotEmpty &&
        cSatuan.text.isNotEmpty &&
        cHargaBeli.text.isNotEmpty &&
        cHargaJual.text.isNotEmpty) {
      String kodeBarang = cKodeBarang.text;
      String barcode = cBarcode.text;
      String nama = cNama.text;
      int stock = int.parse(cStock.text);
      String satuan = cSatuan.text;
      int hargaBeli = int.parse(cHargaBeli.text);
      int hargaJual = int.parse(cHargaJual.text);

      try {
        Database db = await dbInstance.database();
        var query =
            'INSERT INTO master(kd_barang,barcode,nama,stock,satuan,h_beli,h_jual,kategori) VALUES("$kodeBarang","$barcode","$nama",$stock,"$satuan",$hargaBeli,$hargaJual,$idKategori)';
        await db.rawInsert(query);
        customSnackbar(
          context,
          'Berhasil menambah $nama !',
          Colors.green,
          const Duration(seconds: 2),
        );
        getMaster();
      } catch (e) {
        customSnackbar(
          context,
          'gagal menyimpan $e',
          Colors.red,
          const Duration(seconds: 2),
        );
      }
    } else {
      customSnackbar(
        context,
        'salah satu form masih kosong!',
        Colors.red,
        const Duration(seconds: 2),
      );
    }
    notifyListeners();
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
