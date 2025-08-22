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
        title: Text(
          receiverEmail,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // display messages
          Expanded(child: _buildMessages()),
          //  user input
          _buildMessageInput(),
        ],
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
    return Text(data['message']);
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        // textfield should take most of the space
        Expanded(
          child: MyTextField(
            hintText: "type a message...",
            obscureText: false,
            controller: _messageController,
          ),
        ),
        // send button
        IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward)),
      ],
    );
  }
}
