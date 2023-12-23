import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbpos/providers/users_provider.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:sbpos/ui/widgets/custom_textfield.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'Level';

    UsersProvider usersProv =
        Provider.of<UsersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: displayWidth(context),
        height: displayHeight(context),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                      textController: usersProv.cLevel,
                      labelText: 'Level',
                      prefIcon: const Icon(Icons.perm_identity_sharp),
                      colorBorder: Colors.blue,
                      widthBorder: 3,
                      circuralBoder: 5),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Menu Permission'),
                          content: Container(
                            color: Colors.grey[200],
                            width: 300,
                            height: 400,
                            child: Consumer<UsersProvider>(
                              builder: (context, value, child) {
                                return ListView.builder(
                                  itemCount: value.menu.length,
                                  itemBuilder: (context, index) {
                                    var menuTitle = value.menu[index];
                                    String permission = value.permission[index];
                                    return Card(
                                      child: ListTile(
                                        title: Text(menuTitle),
                                        trailing: Checkbox(
                                          value:
                                              permission == '1' ? true : false,
                                          onChanged: (v) {
                                            value.changeCheckbox(v!, index);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.phonelink_setup_rounded,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                usersProv.addLevel(usersProv.cLevel.text.toUpperCase(),
                    usersProv.permission.join(''));
                usersProv.cLevel.clear();
              },
              child: const Text('Save'),
            ),
            Consumer<UsersProvider>(
              builder: (context, value, child) {
                usersProv.getLevel();
                return Expanded(
                  child: ListView.builder(
                    itemCount: value.level.length,
                    itemBuilder: (context, index) {
                      var data = value.level[index];
                      return Card(
                        child: ListTile(
                          title: Text(data.level),
                          onTap: () {
                            value.getLevelById(data.idLevel);

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Edit Menu ${data.level}'),
                                  content: Container(
                                    color: Colors.grey[200],
                                    width: 300,
                                    height: 400,
                                    child: Consumer<UsersProvider>(
                                      builder: (context, value, child) {
                                        return ListView.builder(
                                          itemCount: value.menu.length,
                                          itemBuilder: (context, index) {
                                            var menuTitle = value.menu[index];
                                            String permission =
                                                value.permission[index];
                                            return Card(
                                              child: ListTile(
                                                title: Text(menuTitle),
                                                trailing: Checkbox(
                                                  value: permission == '1'
                                                      ? true
                                                      : false,
                                                  onChanged: (v) {
                                                    value.changeCheckbox(
                                                        v!, index);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        value.updateLevel(
                                            data.idLevel,
                                            data.level.toUpperCase(),
                                            value.permission.join(''));
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Update'),
                                    )
                                  ],
                                );
                              },
                            ).then((v) => value.resetPermission());
                          },
                        ),
                      );
                    },
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
