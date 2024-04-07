import 'package:chat_app/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key, required this.onTap}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final AuthService _auth = AuthService();

  final void Function()? onTap;

  void register(BuildContext context) {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        _auth.signUpWithEmailAndPassword(_emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords do not match"),
        ),
      );
    }
  }

  //pasword do not match

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
            "Lets create an account for you!",
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

//confirm password textfield
          const SizedBox(height: 10),
          MyTextField(hintText: 'Confirm Password', controller: _confirmPasswordController),

          const SizedBox(height: 25),
          //login button
          MyButton(
            text: 'Register',
            onTap: () => register(context),
          ),
          const SizedBox(height: 25),

          //register now
          Text(
            " Already have an account?",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text("Login now",
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
