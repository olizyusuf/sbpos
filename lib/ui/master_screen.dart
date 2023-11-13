import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbpos/providers/master_provider.dart';
import 'package:sbpos/ui/utils.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'Master Stock';

    int pageSize = 10;

    MasterProvider masterProv =
        Provider.of<MasterProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        width: displayWidth(context),
        height: displayHeight(context),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: displayHeight(context) * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/kategori');
                    },
                    child: const Text('Kategori'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      masterProv.clearText();
                      Navigator.pushNamed(context, '/addMaster');
                    },
                    child: const Text('Tambah'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Search'),
                            content: TextField(
                              controller: masterProv.cSearch,
                              decoration: const InputDecoration(
                                  hintText:
                                      'masukan kode barang atau nama cth: 11111 atau mie'),
                            ),
                            alignment: Alignment.center,
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  masterProv.getMaster();
                                  Navigator.pop(context);
                                },
                                child: const Text('Tampilan Semua'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  masterProv.getMasterByKeyword();
                                  Navigator.pop(context);
                                },
                                child: const Text('Cari'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Search'),
                  )
                ],
              ),
            ),
            Consumer<MasterProvider>(
              builder: (context, value, child) {
                return Expanded(
                  child: value.masters.isEmpty
                      ? const Center(
                          child: Text('Data masih Kosong'),
                        )
                      : SingleChildScrollView(
                          child: PaginatedDataTable(
                            columnSpacing: 40,
                            horizontalMargin: 10,
                            rowsPerPage: pageSize,
                            // availableRowsPerPage: const [7, 14, 25],
                            // onRowsPerPageChanged: (value) {
                            //   pageSize = value!;
                            //   debugPrint(value.toString());
                            // },
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Kode Barang',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Barcode',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nama',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Satuan',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Stock',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Harga Beli',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Harga Jual',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Kategori',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Action',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            source: MyData(
                                masterData: value.masters, context: context),
                          ),
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final BuildContext context;
  final List masterData;

  MyData({required this.masterData, required this.context});

  @override
  DataRow? getRow(int index) {
    var data = masterData[index];
    MasterProvider masterProv =
        Provider.of<MasterProvider>(context, listen: false);
    return DataRow(cells: [
      DataCell(
        Text(data.kodeBarang.toString()),
      ),
      DataCell(
        Text(data.barcode),
      ),
      DataCell(
        Text(data.nama.length > 20
            ? '${data.nama.toString().substring(0, 20)}....'
            : data.nama.toString()),
      ),
      DataCell(
        Text(data.satuan.toString()),
      ),
      DataCell(
        Text(data.stock.toString()),
      ),
      DataCell(
        Text(data.hargaBeli.toString()),
      ),
      DataCell(
        Text(data.hargaJual.toString()),
      ),
      DataCell(
        Text(data.namaKategori.toString()),
      ),
      DataCell(
        Row(
          children: [
            IconButton(
              onPressed: () {
                masterProv.cKodeBarang.text = data.kodeBarang;
                masterProv.cBarcode.text = data.barcode;
                masterProv.cNama.text = data.nama;
                masterProv.cSatuan.text = data.satuan;
                masterProv.cStock.text = data.stock.toString();
                masterProv.cHargaBeli.text = data.hargaBeli.toString();
                masterProv.cHargaJual.text = data.hargaJual.toString();
                masterProv.cNamaKategori.text = data.namaKategori.toString();
                masterProv.idKategori = data.idKategori;
                Navigator.pushNamed(context, '/editMaster');
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.remove_circle_outlined,
                color: Colors.red,
              ),
            ),
          ],
        ),
      )
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => masterData.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
