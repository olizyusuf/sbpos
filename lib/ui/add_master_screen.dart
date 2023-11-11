import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbpos/providers/master_provider.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:sbpos/ui/widgets/custom_textfield.dart';

class AddMasterScreen extends StatelessWidget {
  const AddMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'Tambah master data';

    MasterProvider masterProv =
        Provider.of<MasterProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: displayHeight(context),
        width: displayWidth(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextfield(
                textController: masterProv.cKodeBarang,
                labelText: 'Kode Barang',
                prefIcon: const Icon(Icons.numbers),
                colorBorder: Colors.blue,
                widthBorder: 3,
                circuralBoder: 5,
                maxLength: 13,
              ),
              CustomTextfield(
                textController: masterProv.cBarcode,
                labelText: 'Barcode',
                prefIcon: const Icon(Icons.qr_code_2_outlined),
                colorBorder: Colors.blue,
                widthBorder: 3,
                circuralBoder: 5,
                maxLength: 13,
              ),
              CustomTextfield(
                textController: masterProv.cBarcode,
                labelText: 'Nama',
                colorBorder: Colors.blue,
                widthBorder: 3,
                circuralBoder: 5,
              ),
              CustomTextfield(
                textController: masterProv.cBarcode,
                labelText: 'Stock',
                colorBorder: Colors.blue,
                widthBorder: 3,
                circuralBoder: 5,
              ),
              CustomTextfield(
                textController: masterProv.cBarcode,
                labelText: 'Satuan',
                colorBorder: Colors.blue,
                widthBorder: 3,
                circuralBoder: 5,
              ),
              CustomTextfield(
                textController: masterProv.cBarcode,
                labelText: 'Harga Beli',
                colorBorder: Colors.blue,
                widthBorder: 3,
                circuralBoder: 5,
              ),
              CustomTextfield(
                textController: masterProv.cBarcode,
                labelText: 'Harga Jual',
                colorBorder: Colors.blue,
                widthBorder: 3,
                circuralBoder: 5,
              ),
              CustomTextfield(
                textController: masterProv.cBarcode,
                labelText: 'Satuan',
                colorBorder: Colors.blue,
                widthBorder: 3,
                circuralBoder: 5,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('kategori'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
