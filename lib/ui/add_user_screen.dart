import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbpos/providers/users_provider.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:sbpos/ui/widgets/custom_textfield.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'Tambah user';

    UsersProvider usersProv =
        Provider.of<UsersProvider>(context, listen: false);

    usersProv.getLevel();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        width: displayWidth(context),
        height: displayHeight(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextfield(
                  textController: usersProv.cUser,
                  labelText: 'User',
                  maxLength: 12,
                  prefIcon: const Icon(Icons.person),
                  colorBorder: Colors.blue,
                  widthBorder: 3,
                  circuralBoder: 10),
              const SizedBox(
                height: 10,
              ),
              CustomTextfield(
                  textController: usersProv.cPassword,
                  labelText: 'Password',
                  obscureText: true,
                  maxLength: 6,
                  prefIcon: const Icon(Icons.key_rounded),
                  colorBorder: Colors.blue,
                  widthBorder: 3,
                  circuralBoder: 10),
              const SizedBox(
                height: 10,
              ),
              CustomTextfield(
                  textController: usersProv.cRetypePassword,
                  labelText: 'Retype Password',
                  obscureText: true,
                  maxLength: 6,
                  prefIcon: const Icon(Icons.key_rounded),
                  colorBorder: Colors.blue,
                  widthBorder: 3,
                  circuralBoder: 10),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                        textController: usersProv.cLevel,
                        labelText: 'Level',
                        readOnly: true,
                        prefIcon: const Icon(Icons.account_tree),
                        colorBorder: Colors.blue,
                        widthBorder: 3,
                        circuralBoder: 10),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Level'),
                            content: SizedBox(
                              width: 300,
                              height: 300,
                              child: ListView.builder(
                                itemCount: usersProv.level.length,
                                itemBuilder: (context, index) {
                                  var data = usersProv.level[index];
                                  return Card(
                                    shadowColor: Colors.blue,
                                    child: ListTile(
                                      title: Text(data.level),
                                      onTap: () {
                                        usersProv.cLevel.text = data.level;
                                        usersProv.idLevel = data.idLevel;
                                        debugPrint(
                                            usersProv.idLevel.toString());
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
                      Icons.add_box_outlined,
                      size: 40,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      usersProv.addUser(context);
                    },
                    child: const Text('Simpan'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Batal',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
