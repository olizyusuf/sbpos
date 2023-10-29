import 'package:flutter/material.dart';
import 'package:sbpos/ui/utils.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'Master Stock';

    List<Map<String, dynamic>> masterData = [
      {
        'id': 1111111,
        'barcode': '1234562646123',
        'name': 'Susu saya susu bendera kental manis mantab',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 2222222,
        'barcode': '3214562646123',
        'name': 'Mie',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 3333333,
        'barcode': '3332222646123',
        'name': 'Coklat',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 4444444,
        'barcode': '1122332646123',
        'name': 'Pasta',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
      {
        'id': 5555555,
        'barcode': '3241112646123',
        'name': 'Siomey',
        'stock': 10,
        'price': 999000
      },
    ];

    int pageSize = 7;

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
                    onPressed: () {},
                    child: const Text('Category'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Price Level'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Search'),
                  )
                ],
              ),
            ),
            Expanded(
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
                        'Id',
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
                        'Name',
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
                        'Price',
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
                  source: MyData(masterData: masterData),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> masterData;

  MyData({required this.masterData});

  @override
  DataRow? getRow(int index) {
    var data = masterData[index];
    return DataRow(cells: [
      DataCell(
        Text(data['id'].toString()),
      ),
      DataCell(
        Text(data['barcode']),
      ),
      DataCell(
        Text(data['name'].length > 20
            ? '${data['name'].toString().substring(0, 20)}....'
            : data['name'].toString()),
      ),
      DataCell(
        Text(data['stock'].toString()),
      ),
      DataCell(
        Text(data['price'].toString()),
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
