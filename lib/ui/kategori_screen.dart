import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbpos/providers/master_provider.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:sbpos/ui/widgets/custom_textfield.dart';

class Kategori extends StatelessWidget {
  const Kategori({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'Kategori';

    MasterProvider masterProv =
        Provider.of<MasterProvider>(context, listen: false);

    masterProv.getKategori();
    masterProv.cNamaKategori.clear();

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
              CustomTextfield(
                  textController: masterProv.cNamaKategori,
                  labelText: 'Kategori',
                  prefIcon: const Icon(Icons.category_sharp),
                  colorBorder: Colors.blue,
                  widthBorder: 3,
                  circuralBoder: 10),
              ElevatedButton(
                onPressed: () {
                  masterProv.addKategori(context);
                },
                child: const Text('Simpan'),
              ),
              const SizedBox(
                height: 5,
              ),
              Consumer<MasterProvider>(
                builder: (context, value, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: value.kategori.length,
                      itemBuilder: (context, index) {
                        var data = value.kategori[index];
                        return Card(
                          child: ListTile(
                            title: Text(data.nama),
                            onTap: () {
                              value.getKategoriById(data.idKategori);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Edit'),
                                    content: CustomTextfield(
                                        textController:
                                            masterProv.cNamaKategori,
                                        labelText: 'Kategori',
                                        prefIcon:
                                            const Icon(Icons.category_sharp),
                                        colorBorder: Colors.blue,
                                        widthBorder: 3,
                                        circuralBoder: 10),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          value.updateKategori(
                                              context, data.idKategori);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Ubah'),
                                      )
                                    ],
                                  );
                                },
                              ).then(
                                (v) {
                                  value.cNamaKategori.clear();
                                },
                              );
                            },
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Hapus'),
                                        content: Text(
                                            'Apakah kategori ${data.nama} akan dihapus?!'),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              value.deleteKategori(
                                                  context, data.idKategori);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Ya'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Batal'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.red,
                                )),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
