import 'package:flutter/material.dart';

class PenjualanProvider extends ChangeNotifier {
  List tempBarang = [];
  int? subtotal;
  int? ppn;
  int? total;

  TextEditingController cCariKodeBarang = TextEditingController();

  getDataMaster(){
    
  }
}
