import 'package:flutter/material.dart';
import 'package:sbpos/database/database_instance.dart';
import 'package:sbpos/models/detail_penjualan_model.dart';
import 'package:sqflite/sqflite.dart';

class PenjualanProvider extends ChangeNotifier {
  List tempPenjualan = [];

  bool prosen = false;
  int price = 0;
  double ppn = 0;
  double potongan = 0;
  int subtotal = 0;
  double total = 0;
  double bayar = 0;
  double kembali = 0;

  TextEditingController cCariKodeBarang = TextEditingController();
  TextEditingController cQtyItem = TextEditingController();
  TextEditingController cDiskonAmount = TextEditingController();
  TextEditingController cNominalBayar = TextEditingController();

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
    //debugPrint('response database: ' + response.toString());

    bool found = tempPenjualan.any((value) => value.kdBarang == kodeBarang);
    //debugPrint('kode barang sdh ada di temp?:' + found.toString());

    if (found) {
      int index =
          tempPenjualan.indexWhere((element) => element.kdBarang == kodeBarang);
      tempPenjualan[index].jumlah += 1;
      tempPenjualan[index].subtotal =
          tempPenjualan[index].jumlah * tempPenjualan[index].hargaJual;
    } else {
      for (var r in response) {
        // debugPrint(r.toString());
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

    totalTransaksi();
    notifyListeners();
  }

  void adjustJumlah(String kodeBarang, int value) {
    bool found = tempPenjualan.any((value) => value.kdBarang == kodeBarang);
    //debugPrint('kode barang sdh ada di temp?:' + found.toString());

    int index =
        tempPenjualan.indexWhere((element) => element.kdBarang == kodeBarang);
    int qty = int.parse(cQtyItem.text);

    if (found && qty >= 1) {
      tempPenjualan[index].jumlah = value;
      tempPenjualan[index].subtotal =
          tempPenjualan[index].jumlah * tempPenjualan[index].hargaJual;
    }

    totalTransaksi();
    notifyListeners();
  }

  void payment() {}

  void diskonTotal() {
    if (prosen) {
      potongan = subtotal *
          double.parse(
              cDiskonAmount.text.replaceAll(RegExp(","), '').toString());
    } else {
      potongan = double.parse(
          cDiskonAmount.text.replaceAll(RegExp(","), '').toString());
    }
    totalTransaksi();
    notifyListeners();
  }

  void totalTransaksi() {
    subtotal = 0;
    total = 0;
    for (var e in tempPenjualan) {
      int sub = e.jumlah * e.hargaJual;
      subtotal += sub;
      ppn = subtotal * 11 / 100;
      total = subtotal + ppn - potongan;
    }
    notifyListeners();
  }

  void checkItem(context, String kodeBarang) async {
    try {
      Database db = await dbInstance.database();
      var query = 'SELECT * FROM master WHERE kd_barang = $kodeBarang';
      List<Map<String, dynamic>> response = await db.rawQuery(query);
      if (response.isNotEmpty) {
        addToTempPenjualan(kodeBarang);
        totalTransaksi();
      }
      cCariKodeBarang.clear();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return const SimpleDialog(
            contentPadding: EdgeInsets.fromLTRB(10, 5.0, 10.0, 5.0),
            children: [Text("Item tidak ditemukan")],
          );
        },
      );
    }
  }

  void batalItem(int index) {
    tempPenjualan.removeAt(index);

    totalTransaksi();
    notifyListeners();
  }

  void clearAll() {
    tempPenjualan.clear();
    cDiskonAmount.clear();
    cNominalBayar.clear();
    prosen = false;
    price = 0;
    ppn = 0;
    potongan = 0;
    subtotal = 0;
    total = 0;
    bayar = 0;
    kembali = 0;
  }
}
