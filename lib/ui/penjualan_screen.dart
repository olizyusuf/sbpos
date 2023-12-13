import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbpos/providers/penjualan_provider.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class PenjualanScreen extends StatelessWidget {
  const PenjualanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Penjualan";

    PenjualanProvider penjualanProv =
        Provider.of<PenjualanProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: displayHeightBody(context),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                margin: const EdgeInsets.only(bottom: 5),
                width: displayWidth(context),
                height: displayHeight(context) * 0.06,
                child: TypeAheadField<Map<String, dynamic>>(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    controller: penjualanProv.cCariKodeBarang,
                    onSubmitted: (value) {
                      penjualanProv.checkItem(context, value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari Kode / Nama Item',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.barcode_reader),
                        onPressed: () {
                          debugPrint('Scan Barcode');
                        },
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) async =>
                      await penjualanProv.getDataMaster(pattern),
                  itemBuilder: (context, Map<String, dynamic> suggestion) {
                    return ListTile(
                      title: Text(suggestion['kd_barang']),
                      subtitle: Text(
                        suggestion['nama'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(numToIdr(suggestion['harga_jual']),
                          style: const TextStyle(fontSize: 18)),
                    );
                  },
                  itemSeparatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  onSuggestionSelected: (suggestion) {
                    penjualanProv.addToTempPenjualan(suggestion['kd_barang']);
                    penjualanProv.cCariKodeBarang.clear();
                  },
                  suggestionsBoxDecoration: SuggestionsBoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 8.0,
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ),
              Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  height: displayHeight(context) * 0.65,
                  child: Consumer<PenjualanProvider>(
                    builder: (context, value, child) {
                      return value.tempPenjualan.isNotEmpty
                          ? ListView.builder(
                              itemCount: value.tempPenjualan.length,
                              itemBuilder: (context, index) {
                                var data = value.tempPenjualan[index];
                                return Container(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.grey[200],
                                  height: 40,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: displayWidth(context) * 0.05,
                                        child: Text(
                                          "${index + 1} ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[500]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: displayWidth(context) * 0.6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.nama,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${data.jumlah} x ",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  numToIdr(data.hargaJual),
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: displayWidth(context) * 0.2,
                                        child: Text(numToIdr(data.subtotal),
                                            style:
                                                const TextStyle(fontSize: 14)),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.delete),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text('Item masih kosong...'),
                            );
                    },
                  )),
              Container(
                child: Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: displayWidth(context) * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Subtotal: ${numToIdr(8000000)}"),
                            Text("Diskon: ${numToIdr(40000)}"),
                            Text("PPN 11%: ${numToIdr(98400)}")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.amber,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Total : ${numToIdr(90000000)}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 150,
                                height: 45,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Bayar")),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
