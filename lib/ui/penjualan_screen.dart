import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
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
                                  height: 60,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: displayWidth(context) * 0.05,
                                        child: Text(
                                          "${index + 1} ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[500]),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              penjualanProv.cQtyItem.text =
                                                  data.jumlah.toString();
                                              return AlertDialog(
                                                title: const Text("Jumlah"),
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        100, 5, 100, 0),
                                                content: SizedBox(
                                                  child: TextField(
                                                    autofocus: true,
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller:
                                                        penjualanProv.cQtyItem,
                                                  ),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      penjualanProv
                                                          .adjustJumlah(
                                                              data.kdBarang,
                                                              int.parse(
                                                                  penjualanProv
                                                                      .cQtyItem
                                                                      .text));
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Simpan"),
                                                  ),
                                                ],
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                              );
                                            },
                                          );
                                        },
                                        child: SizedBox(
                                          width: displayWidth(context) * 0.6,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.kdBarang,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                data.nama,
                                                style: const TextStyle(
                                                    fontSize: 14),
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
                                      ),
                                      SizedBox(
                                        width: displayWidth(context) * 0.2,
                                        child: Text(numToIdr(data.subtotal),
                                            style:
                                                const TextStyle(fontSize: 14)),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Batalkan ${data.nama}?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Tidak'),
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          penjualanProv
                                                              .batalItem(index);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text('Ya'))
                                                  ],
                                                );
                                              },
                                            );
                                          },
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
              Expanded(
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        width: displayWidth(context) * 0.4,
                        child: Consumer<PenjualanProvider>(
                          builder: (context, sub, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Subtotal: ${numToIdr(sub.subtotal)}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Diskon"),
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      100, 5, 100, 0),
                                              content: SizedBox(
                                                child: TextField(
                                                  autofocus: true,
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: penjualanProv
                                                      .cDiskonAmount,
                                                  inputFormatters: [
                                                    CurrencyTextInputFormatter(
                                                        decimalDigits: 0,
                                                        symbol: '')
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    penjualanProv.diskonTotal();
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Simpan"),
                                                ),
                                              ],
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        "Diskon",
                                        style: TextStyle(
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(" : ${numToIdr(sub.potongan)}",
                                        style: const TextStyle(fontSize: 16)),
                                  ],
                                ),
                                Text("PPN 11%: ${numToIdr(sub.ppn)}",
                                    style: const TextStyle(fontSize: 16))
                              ],
                            );
                          },
                        )),
                    Expanded(
                      child: Container(
                        color: Colors.grey[400],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Consumer<PenjualanProvider>(
                              builder: (context, ttl, child) {
                                return Text(
                                  "Total : ${numToIdr(ttl.total)}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                            SizedBox(
                              width: 150,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  penjualanProv.tempPenjualan.isNotEmpty
                                      ? showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Bayar"),
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              content: SizedBox(
                                                height: 200,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Total : Rp. ${numToIdr(penjualanProv.total)}',
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    TextField(
                                                      autofocus: true,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      controller: penjualanProv
                                                          .cNominalBayar,
                                                      inputFormatters: [
                                                        CurrencyTextInputFormatter(
                                                            decimalDigits: 0,
                                                            symbol: '')
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text('Uang Pas'),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            penjualanProv
                                                                .cNominalBayar
                                                                .text = "5,000";
                                                          },
                                                          child: const Text(
                                                              ' 5.000 '),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            penjualanProv
                                                                .cNominalBayar
                                                                .text = "10,000";
                                                          },
                                                          child: const Text(
                                                              ' 10.000 '),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            penjualanProv
                                                                .cNominalBayar
                                                                .text = "20,000";
                                                          },
                                                          child: const Text(
                                                              '20.000'),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            penjualanProv
                                                                .cNominalBayar
                                                                .text = "50,000";
                                                          },
                                                          child: const Text(
                                                              '50.000'),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            penjualanProv
                                                                .cNominalBayar
                                                                .text = "100,000";
                                                          },
                                                          child: const Text(
                                                              '100.000'),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            penjualanProv
                                                                .cNominalBayar
                                                                .clear();
                                                          },
                                                          child: const Text(
                                                              'Custom'),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, false);
                                                  },
                                                  child: const Text('Batal'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (penjualanProv
                                                            .cNominalBayar
                                                            .text
                                                            .isNotEmpty &&
                                                        penjualanProv.total <=
                                                            double.parse(
                                                              penjualanProv
                                                                  .cNominalBayar
                                                                  .text
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ","),
                                                                      '')
                                                                  .toString(),
                                                            )) {
                                                      penjualanProv.bayar =
                                                          double.parse(
                                                        penjualanProv
                                                            .cNominalBayar.text
                                                            .replaceAll(
                                                                RegExp(","), '')
                                                            .toString(),
                                                      );
                                                      penjualanProv.kembali =
                                                          penjualanProv.total -
                                                              penjualanProv
                                                                  .bayar;
                                                      Navigator.pop(
                                                          context, true);
                                                    } else {
                                                      customSnackbar(
                                                          context,
                                                          'Nominal harus sesuai',
                                                          Colors.red,
                                                          const Duration(
                                                              seconds: 1));
                                                    }
                                                  },
                                                  child: const Text("Bayar"),
                                                ),
                                              ],
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                            );
                                          },
                                        ).then(
                                          (val) {
                                            try {
                                              if (val) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Pembayaran Berhasil"),
                                                      content: SizedBox(
                                                        height: 120,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Total: Rp. ${numToIdr(penjualanProv.total)}',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Bayar: Rp. ${numToIdr(penjualanProv.bayar)}',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Kembali: Rp. ${numToIdr(penjualanProv.kembali.abs())}',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 27,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context, true);
                                                          },
                                                          child:
                                                              const Text("OK"),
                                                        ),
                                                      ],
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                    );
                                                  },
                                                ).then((value) {
                                                  penjualanProv.clearAll();
                                                  Navigator.of(context)
                                                      .pushNamedAndRemoveUntil(
                                                          '/menu',
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                });
                                              }
                                              penjualanProv.cNominalBayar
                                                  .clear();
                                            } catch (e) {
                                              debugPrint(e.toString());
                                            }
                                          },
                                        )
                                      : customSnackbar(
                                          context,
                                          'Transaksi masih kosong.',
                                          Colors.red,
                                          const Duration(seconds: 3),
                                        );
                                },
                                child: const Text("Bayar"),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
