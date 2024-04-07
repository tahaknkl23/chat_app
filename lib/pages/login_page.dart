import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, required this.onTap});

  //email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //tap to go to register page
  void Function()? onTap;

// Login Method
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    }

    //catch any errors
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50),

          //welcome back message
          Text(
            "Welcome back you've been missed",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 25),
          //emait textfield
          MyTextField(hintText: 'Email', controller: _emailController),
          //password textfield
          const SizedBox(height: 10),
          MyTextField(hintText: 'Password', controller: _passwordController),
          const SizedBox(height: 25),
          //login button
          MyButton(
            text: 'Login',
            onTap: () => login(context),
          ),
          const SizedBox(height: 25),

          //register now
          Text(
            " Not a member? ",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: () {
              onTap!();
            },
            child: Text("Register now",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                )),
          ),
        ],
      ),
    );
  }
}
