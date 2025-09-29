import 'package:chatapp/components/settings_tile.dart';
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
            SettingsTile(
              bbottom: 20,
              leadingIcon: Icons.person,
              trailingIcon: Icons.arrow_forward_ios,
              title: "Profil",
              subtitle: "Show your informations",
              onTap: () => Get.toNamed('/profil'),
            ),

            // Section thème
            SettingsTile(
              bbottom: 20,
              leadingIcon: Icons.palette,
              trailingIcon: Icons.arrow_forward_ios,
              title: "Appearance",
              subtitle: "Mode clair/sombre",
              onTap: () => Get.toNamed('/light-dark'),
            ),

            // Section à propos
            SettingsTile(
              bbottom: 0,
              leadingIcon: Icons.palette,
              trailingIcon: Icons.arrow_forward_ios,
              title: "About",
              subtitle: "Version et informations",
              onTap: () => Get.toNamed('/about'),
            ),
          ],
        ),
      ),
    );
  }
}
