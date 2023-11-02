import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbpos/providers/login_provider.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:sbpos/ui/widgets/custom_card.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'Menu SB Pos';

    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure logout from SB Pos ?!'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('Cancel'),
                      )
                    ],
                  );
                },
              ).then(
                (v) {
                  if (v) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          height: displayHeight(context),
          width: displayWidth(context),
          child: Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.1,
                width: displayWidth(context),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome back ${loginProvider.user}!'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.7,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    CustomCard(
                      titleCard: 'Master',
                      iconCard: const Icon(
                        Icons.inventory_2_rounded,
                        size: 70,
                        color: Colors.blue,
                      ),
                      onTapCallback: () {
                        Navigator.pushNamed(context, '/master');
                      },
                    ),
                    CustomCard(
                      titleCard: 'Users',
                      iconCard: const Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.blue,
                      ),
                      onTapCallback: () {
                        Navigator.pushNamed(context, '/users');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
