class MasterModel {
  String? kodeBarang;
  String? barcode;
  String? nama;
  double? stock;
  String? satuan;
  double? hargaBeli;
  double? hargaJual;
  int? idKategori;
  String? createAt;
  String? updateAt;

  MasterModel({
    required this.kodeBarang,
    required this.barcode,
    required this.nama,
    required this.stock,
    required this.satuan,
    required this.hargaBeli,
    required this.hargaJual,
    required this.idKategori,
    required this.createAt,
    required this.updateAt,
  });
}
