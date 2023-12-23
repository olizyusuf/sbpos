import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbpos/providers/users_provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String usersTitle = 'Users';

    UsersProvider usersProv =
        Provider.of<UsersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(usersTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/level');
                  },
                  child: const Text('Level'),
                ),
                ElevatedButton(
                  onPressed: () {
                    usersProv.clearTextField();
                    Navigator.pushNamed(context, '/addUser');
                  },
                  child: const Text('Tambah'),
                ),
              ],
            ),
            Consumer<UsersProvider>(
              builder: (context, value, child) {
                usersProv.getUsers();
                return Expanded(
                  child: value.users.length.isNaN
                      ? const Center(
                          child: Text('Users masih kosong'),
                        )
                      : ListView.builder(
                          itemCount: value.users.length,
                          itemBuilder: (context, index) {
                            var userData = value.users[index];
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: index % 2 == 0
                                      ? Colors.blueAccent
                                      : Colors.purpleAccent,
                                  child:
                                      Text('${userData.user[0].toUpperCase()}'),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(userData.user),
                                    Text('Level ${userData.level}'),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        value.idUser = userData.id;
                                        value.cUser.text = userData.user;
                                        value.cPassword.text =
                                            userData.password;
                                        value.cRetypePassword.text =
                                            userData.password;
                                        value.idLevel = userData.idLevel;
                                        value.cLevel.text = userData.level;
                                        Navigator.pushNamed(
                                            context, '/editUser');
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Hapus'),
                                              content: Text(
                                                  'Apakah yakin ${userData.user} dihapus?!'),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, true);
                                                  },
                                                  child: const Text('Ya'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, false);
                                                  },
                                                  child: const Text('Batal'),
                                                )
                                              ],
                                            );
                                          },
                                        ).then(
                                          (v) {
                                            if (v) {
                                              value.deleteUser(
                                                  context, userData.id);
                                            }
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
