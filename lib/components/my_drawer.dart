import 'package:chat_app/pages/settings.page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void _logout() {
    //get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // logo and menu items
          Column(
            children: [
              // logo
              DrawerHeader(
                child: Center(
                  child: Icon(Icons.message, size: 64, color: Theme.of(context).colorScheme.primary),
                ),
              ),

              // home list tile
              ListTile(
                title: const Text("H O M E"),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                  // Handle home navigation
                },
              ),

              // settings list tile
              ListTile(
                title: const Text("S E T T I N G S"),
                leading: const Icon(Icons.settings),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                },
              ),
            ],
          ),

          // logout list tile
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                title: const Text("L O G O U T"),
                leading: const Icon(Icons.logout),
                onTap: _logout,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
