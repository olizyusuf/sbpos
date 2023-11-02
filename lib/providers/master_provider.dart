import 'package:flutter/material.dart';
import 'package:sbpos/database/database_instance.dart';

class MasterProvider extends ChangeNotifier {
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

  getKategori() {
// todo here
  }

  addKategori() {
// todo here
  }

  updateKategori() {
// todo here
  }
}
