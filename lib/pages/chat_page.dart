import 'package:chatapp/components/chat_bubble.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;

  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and auth services
  final AuthService authservice = AuthService();
  final ChatService chatservice = ChatService();

  // function to send a message
  void sendMessage() async {
    // check if there is a message in the controller
    if (_messageController.text.isNotEmpty) {
      //send the message
      await chatservice.sendMessage(receiverId, _messageController.text);
      // clear the contoller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // display messages
              Expanded(child: _buildMessages()),
              //  user input
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  // build messages
  Widget _buildMessages() {
    String senderId = authservice.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: chatservice.getMessages(receiverId, senderId),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // return listview
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user ?
    bool isCurrentUser = data['senderId'] == authservice.getCurrentUser()!.uid;

    // align message to the right if sender is the current user, otherwise left
    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          // textfield should take most of the space
          Expanded(
            child: MyTextField(
              horizontal: 0.0,
              hintText: "Type a message...",
              obscureText: false,
              controller: _messageController,
            ),
          ),
          const SizedBox(width: 10),
          // send button
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
