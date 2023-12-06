import 'package:flutter/material.dart';
import 'package:sbpos/ui/utils.dart';

class PenjualanScreen extends StatelessWidget {
  const PenjualanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Penjualan";

    int qty = 20;
    int price = 10000;
    int subtotal = qty * price;

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
                child: const TextField(
                  decoration: InputDecoration(
                      hintText: "Cari atau scan kode barang disini..."),
                ),
              ),
              Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.only(left: 5, right: 10),
                height: displayHeight(context) * 0.65,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      color: index % 2 == 0 ? Colors.white : Colors.grey[200],
                      height: 40,
                      child: Row(
                        children: [
                          SizedBox(
                            width: displayWidth(context) * 0.05,
                            child: Text(
                              "${index + 1} ",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[500]),
                            ),
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Nama Barang Disini",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "$qty x ",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      numToIdr(price),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.2,
                            child: Text(numToIdr(subtotal),
                                style: const TextStyle(fontSize: 14)),
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
                ),
              ),
              Expanded(
                child: Container(
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
