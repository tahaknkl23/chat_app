import 'package:chat_app/auth/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _logout() {
    //get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          //logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              //logout
              _logout();
            },
          ),
        ],
      ),
      drawer: const Drawer(),
    );
  }
}
