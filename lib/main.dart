import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbpos/providers/login_provider.dart';
import 'package:sbpos/providers/master_provider.dart';
import 'package:sbpos/providers/users_provider.dart';
import 'package:sbpos/ui/add_master_screen.dart';
import 'package:sbpos/ui/add_user_screen.dart';
import 'package:sbpos/ui/edit_master_screen.dart';
import 'package:sbpos/ui/edit_user_screen.dart';
import 'package:sbpos/ui/kategori_screen.dart';
import 'package:sbpos/ui/level_screen.dart';
import 'package:sbpos/ui/login_screen.dart';
import 'package:sbpos/ui/master_screen.dart';
import 'package:sbpos/ui/menu_screen.dart';
import 'package:sbpos/ui/penjualan_screen.dart';
import 'package:sbpos/ui/users_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MasterProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'SBPos',
        home: const LoginScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/menu': (context) => const MenuScreen(),
          '/users': (context) => const UsersScreen(),
          '/addUser': (context) => const AddUserScreen(),
          '/editUser': (context) => const EditUserScreen(),
          '/level': (context) => const LevelScreen(),
          '/master': (context) => const MasterScreen(),
          '/addMaster': (context) => const AddMasterScreen(),
          '/editMaster': (context) => const EditMasterScreen(),
          '/kategori': (context) => const Kategori(),
          '/penjualan': (context) => const PenjualanScreen(),
        },
      ),
    );
  }
}
