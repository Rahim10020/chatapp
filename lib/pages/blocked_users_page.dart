import 'package:chatapp/components/user_tile.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({super.key});

  // chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //show unblock box
  void _showUnblockBox(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Unblock user",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        content: Text(
          "Are you sure you want to unblok this user ?",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          // unblock button
          TextButton(
            onPressed: () {
              _chatService.unblockUser(userId);
              Get.back();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("User unblocked")));
            },
            child: Text(
              "Unblock",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get current user idb
    String userId = _authService.getCurrentUser()!.uid;

    return Scaffold(
      appBar: AppBar(title: const Text("BLOCKED USERS"), actions: []),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getBlockedUsers(userId),
        builder: (context, snapshot) {
          // errors
          if (snapshot.hasError) {
            return const Center(child: Text("Error ! loading..."));
          }

          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final blockedUsers = snapshot.data ?? [];

          // no users
          if (blockedUsers.isEmpty) {
            return Center(
              child: Text(
                "No blocked Users",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            );
          }

          // return list view
          return ListView.builder(
            itemBuilder: (context, index) {
              final blockedUser = blockedUsers[index];
              return UserTile(
                onTap: () => _showUnblockBox(context, blockedUser['uid']),
                text: blockedUser['email'],
              );
            },
          );
        },
      ),
    );
  }
}
