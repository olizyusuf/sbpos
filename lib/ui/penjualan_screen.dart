import 'package:flutter/material.dart';

class PenjualanScreen extends StatelessWidget {
  const PenjualanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Penjualan";
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text("halaman penjualan"),
      ),
    );
  }
}
