class DetailPenjualanModel {
  int? idDetailPenjualan;
  String? idPenjualan;
  String? kdBarang;
  String? nama;
  int? hargaJual;
  int? jumlah;
  int? diskon;
  int? subtotal;
  String? createAt;
  String? updateAt;

  DetailPenjualanModel(
      {required this.idDetailPenjualan,
      required this.idPenjualan,
      required this.kdBarang,
      required this.nama,
      required this.hargaJual,
      required this.jumlah,
      required this.diskon,
      required this.subtotal,
      required this.createAt,
      required this.updateAt});
}



/*


CREATE TABLE "detail_penjualan" (
	"id_detail_penjualan"	INTEGER NOT NULL,
	"id_penjualan"	TEXT,
	"kd_barang"	TEXT,
	"nama"	TEXT,
	"harga_jual"	INTEGER,
	"jumlah"	INTEGER,
	"diskon"	INTEGER,
	"subtotal"	INTEGER,
	"create_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
	"update_at"	DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id_detail_penjualan" AUTOINCREMENT)
);


*/