import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.green : Colors.grey.shade500,
        borderRadius: isCurrentUser
            ? BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : BorderRadius.only(
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
      child: Text(message, style: TextStyle(color: Colors.white)),
    );
  }
}
