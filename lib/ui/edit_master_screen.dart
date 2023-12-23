import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbpos/providers/master_provider.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:sbpos/ui/widgets/custom_textfield.dart';

class EditMasterScreen extends StatelessWidget {
  const EditMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'Edit master data';

    MasterProvider masterProv =
        Provider.of<MasterProvider>(context, listen: false);

    masterProv.getKategori();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: displayHeight(context),
        width: displayWidth(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                CustomTextfield(
                  textController: masterProv.cKodeBarang,
                  labelText: 'Kode Barang',
                  prefIcon: const Icon(Icons.numbers),
                  colorBorder: Colors.blue,
                  widthBorder: 1,
                  circuralBoder: 5,
                  readOnly: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextfield(
                        textController: masterProv.cBarcode,
                        labelText: 'Barcode',
                        colorBorder: Colors.blue,
                        widthBorder: 1,
                        circuralBoder: 5,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.qr_code_2_outlined,
                          size: 36,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextfield(
                        textController: masterProv.cNama,
                        labelText: 'Nama',
                        colorBorder: Colors.blue,
                        widthBorder: 1,
                        circuralBoder: 5,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 75,
                      child: CustomTextfield(
                        textController: masterProv.cStock,
                        labelText: 'Stock',
                        colorBorder: Colors.blue,
                        widthBorder: 1,
                        circuralBoder: 5,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: CustomTextfield(
                        textController: masterProv.cHargaBeli,
                        labelText: 'Harga Beli',
                        colorBorder: Colors.blue,
                        widthBorder: 1,
                        circuralBoder: 5,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: CustomTextfield(
                        textController: masterProv.cHargaJual,
                        labelText: 'Harga Jual',
                        colorBorder: Colors.blue,
                        widthBorder: 1,
                        circuralBoder: 5,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 75,
                      child: CustomTextfield(
                        textController: masterProv.cSatuan,
                        labelText: 'Satuan',
                        colorBorder: Colors.blue,
                        widthBorder: 1,
                        circuralBoder: 5,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: CustomTextfield(
                              textController: masterProv.cNamaKategori,
                              labelText: 'Kategori',
                              readOnly: true,
                              colorBorder: Colors.blue,
                              widthBorder: 1,
                              circuralBoder: 5,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Kategori'),
                                      content: SizedBox(
                                        width: 300,
                                        height: 300,
                                        child: ListView.builder(
                                          itemCount: masterProv.kategori.length,
                                          itemBuilder: (context, index) {
                                            var data =
                                                masterProv.kategori[index];
                                            return Card(
                                              shadowColor: Colors.blue,
                                              child: ListTile(
                                                title: Text(data.nama),
                                                onTap: () {
                                                  masterProv.cNamaKategori
                                                      .text = data.nama;
                                                  masterProv.idKategori =
                                                      data.idKategori;
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.list_alt_outlined,
                                size: 35,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        masterProv.clearText();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Batal',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        masterProv.updateMaster(context);
                      },
                      child: const Text('Update'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
