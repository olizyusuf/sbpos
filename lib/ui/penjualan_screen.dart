import 'package:flutter/material.dart';
import 'package:sbpos/ui/utils.dart';

class PenjualanScreen extends StatelessWidget {
  const PenjualanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Penjualan";
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
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Cari atau scan kode barang disini..."),
                ),
              ),
              Container(
                color: Colors.grey[100],
                height: displayHeight(context) * 0.65,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      color: index % 2 == 0 ? Colors.white : Colors.grey[200],
                      height: 30,
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
                                Text(
                                  "Nama Barang Disini",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "20 x  ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "20000",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.2,
                            child: Text("4000000"),
                          ),
                          Expanded(
                            child: Icon(Icons.remove_circle_outline),
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
                            Text("Subtotal: 18000000"),
                            Text("Diskon: 45000"),
                            Text("PPN 11%: 80000")
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
                                "Total : 8000000",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Bayar: ",
                                  ),
                                  SizedBox(
                                    height: 25,
                                    width: 100,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 150,
                                height: 30,
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
