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
      body: SizedBox(
          width: displayWidth(context),
          height: displayHeight(context),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: TextField(),
              ),
              Container(
                  height: displayHeight(context) * 0.6,
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("test"),
                      );
                    },
                  )),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      color: Colors.blue,
                      width: 275,
                    ),
                    Expanded(child: Text("Total"))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
