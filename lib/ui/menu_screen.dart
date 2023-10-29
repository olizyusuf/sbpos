import 'package:flutter/material.dart';
import 'package:sbpos/ui/widgets/custom_card.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'Menu SB Pos';

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
      body: GridView.count(
        padding: const EdgeInsets.all(15),
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
    );
  }
}
