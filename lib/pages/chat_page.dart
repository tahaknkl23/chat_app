// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.receiverEmail,
    required this.receiverUid,
    required this.senderUid,
  }) : super(key: key);
  final String receiverEmail;
  final String receiverUid;
  final String senderUid;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _chatService.getMessages(receiverUid: widget.receiverUid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!.map<Widget>((message) {
                        return MessageWidget(currentUserUid: widget.senderUid, message: message);
                      }).toList(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading...");
                  } else {
                    return const Center(
                      child: Text("Error"),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Type a message",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: IconButton(
                      onPressed: () async {
                        MessageModel message = MessageModel(
                          message: _messageController.text,
                          recieverUid: widget.receiverUid,
                          receiverUid: '',
                        );
                        await _chatService.sendMessage(message: message).whenComplete(() => _messageController.clear());
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.message, required this.currentUserUid});
  final MessageModel message;
  final String currentUserUid;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: currentUserUid == message.senderUid ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
        child: Card(
          child: ListTile(
            title: Text(message.message),
          ),
        ),
      ),
    );
  }
}
