import 'package:flutter/material.dart';
import 'package:sbpos/database/database_instance.dart';
import 'package:sbpos/models/master_model.dart';
import 'package:sqflite/sqflite.dart';

class PenjualanProvider extends ChangeNotifier {
  List masters = [];
  List tempPenjualan = [];

  int qty = 1;
  int price = 0;

  int? ppn;
  int? total;

  TextEditingController cCariKodeBarang = TextEditingController();

  DatabaseInstance dbInstance = DatabaseInstance.instance;

  Future getDataMaster(String value) async {
    if (value.isNotEmpty) {
      Database db = await dbInstance.database();
      var query =
          'SELECT kd_barang,barcode,master.nama,stock,satuan,harga_beli,harga_jual,kategori,kategori.nama as nama_kategori,master.create_at,master.update_at FROM master LEFT JOIN kategori ON kategori.id_kategori = master.kategori WHERE master.nama like "$value%" OR master.kd_barang like "$value%"';
      List<Map<String, dynamic>> response = await db.rawQuery(query);

      return response;
    } else {
      List<Map<String, dynamic>> response = [];

      return response;
    }
  }

  addToTempPenjualan(String kodeBarang) async {
    Database db = await dbInstance.database();
    var query = 'SELECT * FROM master WHERE kd_barang = $kodeBarang';
    List<Map<String, dynamic>> response = await db.rawQuery(query);
    debugPrint(response.toString());

    bool found = tempPenjualan.any((value) => value['kd_barang'] == kodeBarang);
    debugPrint(found.toString());

    debugPrint(tempPenjualan.length.toString());
    notifyListeners();
  }
}
