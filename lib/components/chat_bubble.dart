import 'package:chatapp/controllers/theme_controller.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final String userId;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageId,
    required this.userId,
  });

  // show options
  void _showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              // report button
              ListTile(
                leading: Icon(Icons.flag),
                title: const Text("Report"),
                onTap: () {
                  Get.back();
                  _reportMessage(context, messageId, userId);
                },
              ),
              // block button
              ListTile(
                leading: Icon(Icons.block),
                title: const Text("Block"),
                onTap: () {
                  Get.back();
                  _blockUser(context, userId);
                },
              ),
              // cancel button
              ListTile(
                leading: Icon(Icons.cancel),
                title: const Text("Cancel"),
                onTap: () => Get.back(),
              ),
            ],
          ),
        );
      },
    );
  }

  // report message
  void _reportMessage(BuildContext context, String messageId, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Report message"),
        content: const Text("Are you sure you want to report this message ?"),
        actions: [
          // cancel textButton
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),

          // report textButton
          TextButton(
            onPressed: () {
              ChatService().reportUser(messageId, userId);
              Get.back();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Message reported")));
            },
            child: const Text("Report"),
          ),
        ],
      ),
    );
  }

  // block user
  void _blockUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Block user"),
        content: const Text("Are you sure you want to block this user ?"),
        actions: [
          // cancel textButton
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),

          // block textButton
          TextButton(
            onPressed: () {
              ChatService().blockUser(userId);
              Get.back();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("User blocked")));
            },
            child: const Text("Block"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GestureDetector(
          onLongPress: () {
            if (!isCurrentUser) {
              _showOptions(context, messageId, userId);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? Colors.green
                  : themeController.isDarkMode
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: isCurrentUser
                  ? BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(
              message,
              style: TextStyle(
                color: isCurrentUser
                    ? Colors.white
                    : Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        );
      },
    );
  }
}
