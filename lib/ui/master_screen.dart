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

    masterProv.getMaster();

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
                    onPressed: () {},
                    child: const Text('Search'),
                  )
                ],
              ),
            ),
            Consumer<MasterProvider>(
              builder: (context, value, child) {
                return Expanded(
                  child: SingleChildScrollView(
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
                            'Action',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      source: MyData(masterData: value.masters),
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
  final List masterData;

  MyData({required this.masterData});

  @override
  DataRow? getRow(int index) {
    var data = masterData[index];
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
        Row(
          children: [
            IconButton(
              onPressed: () {},
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
