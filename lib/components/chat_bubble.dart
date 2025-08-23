import 'package:chatapp/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

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
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return Container(
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
        );
      },
    );
  }
}
