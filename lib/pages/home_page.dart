import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.currentUid});
  final String currentUid;

  //chat & auth services
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: _buildUserList(),
      ),
    );
  }

  //build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
          );
        }
        //loading...
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      },
    );
  }

  // builde individual user list tile for user
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    //display all users except current  user

    return currentUid == userData["uid"]
        ? const SizedBox()
        : UserTile(
            text: userData['email'],
            onTap: () {
              //tapped on a user -> go to chat page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverEmail: userData["email"],
                    receiverUid: userData["uid"],
                    senderUid: currentUid,
                  ),
                ),
              );
            },
          );
  }
}
