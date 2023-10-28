import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbpos/providers/login_provider.dart';
import 'package:sbpos/ui/utils.dart';
import 'package:sbpos/ui/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'SB POS';
    String loginTitle = 'Login';

    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        width: displayWidth(context),
        height: displayHeight(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                loginTitle,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: displayWidth(context) * 0.75,
                child: CustomTextfield(
                    textController: loginProvider.cIdUser,
                    labelText: 'Login',
                    maxLength: 10,
                    prefIcon: const Icon(Icons.person),
                    colorBorder: Colors.blue,
                    widthBorder: 3,
                    circuralBoder: 10),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: displayWidth(context) * 0.75,
                child: CustomTextfield(
                    textController: loginProvider.cPassword,
                    labelText: 'Password',
                    maxLength: 6,
                    obscureText: true,
                    prefIcon: const Icon(Icons.key),
                    colorBorder: Colors.blue,
                    widthBorder: 3,
                    circuralBoder: 10),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  loginProvider.login(context);
                },
                child: Text(loginTitle),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('$title All Right Reserve 2023 by olizyusuf.my.id')
            ],
          ),
        ),
      ),
    );
  }
}
