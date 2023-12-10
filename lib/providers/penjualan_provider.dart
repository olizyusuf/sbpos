import 'package:flutter/material.dart';
import 'package:sbpos/database/database_instance.dart';
import 'package:sbpos/models/detail_penjualan_model.dart';
import 'package:sqflite/sqflite.dart';

class PenjualanProvider extends ChangeNotifier {
  List tempPenjualan = [];

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

  void addToTempPenjualan(String kodeBarang) async {
    Database db = await dbInstance.database();
    var query = 'SELECT * FROM master WHERE kd_barang = $kodeBarang';
    List<Map<String, dynamic>> response = await db.rawQuery(query);
    debugPrint('response database: ' + response.toString());

    bool found = tempPenjualan.any((value) => value.kdBarang == kodeBarang);
    debugPrint('kode barang sdh ada di temp?:' + found.toString());

    if (found) {
      int index =
          tempPenjualan.indexWhere((element) => element.kdBarang == kodeBarang);
      tempPenjualan[index].jumlah += 1;
      tempPenjualan[index].subtotal =
          tempPenjualan[index].jumlah * tempPenjualan[index].hargaJual;
    } else {
      for (var r in response) {
        debugPrint(r.toString());
        int jmlh = 1;
        int subttl = r['harga_jual'] * jmlh;
        tempPenjualan.add(DetailPenjualanModel(
            idDetailPenjualan: 1,
            idPenjualan: '10001',
            kdBarang: r['kd_barang'],
            nama: r['nama'],
            hargaJual: r['harga_jual'],
            jumlah: jmlh,
            diskon: 0,
            subtotal: subttl,
            createAt: r['create_at'],
            updateAt: r['update_at']));
      }
    }

    debugPrint('jumlah data temp: ' + tempPenjualan.length.toString());
    notifyListeners();
  }
}
