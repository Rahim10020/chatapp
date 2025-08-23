import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Section profil
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Profil"),
                subtitle: const Text("Modifier vos informations"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  Get.snackbar(
                    "Information",
                    "Page profil à implémenter",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ),

            // Section notifications
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Notifications"),
                subtitle: const Text("Gérer les notifications"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  Get.snackbar(
                    "Information",
                    "Page notifications à implémenter",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ),

            // Section thème
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: Icon(
                  Icons.palette,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Thème"),
                subtitle: const Text("Mode clair/sombre"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  Get.snackbar(
                    "Information",
                    "Changement de thème à implémenter",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ),

            // Section à propos
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.info,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("À propos"),
                subtitle: const Text("Version et informations"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      title: const Text("À propos"),
                      content: const Text(
                        "Chat App v1.0.0\n\nUne application de chat développée avec Flutter et Firebase.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
