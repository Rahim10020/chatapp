import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void gotoSettings() {
    // fermer le drawer
    Get.back();
    // aller au settings
    Get.toNamed('/settings');
  }

  void gotoHome() {
    // fermer le drawer
    Get.back();
    // aller au home
    Get.offAllNamed('/home');
  }

  void logout() {
    // afficher une boite de dialogue de confirmation
    Get.dialog(
      AlertDialog(
        title: const Text("Deconnexion"),
        content: const Text("Etes vous sur de vouloir vous deconnecter"),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Annuler")),
          TextButton(
            onPressed: () {
              // close the dialog box
              Get.back();
              final authService = AuthService();
              authService.signOut();
            },
            child: const Text("Deconnexion"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // logo
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.message,
                size: 50,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          // home list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text(
                "Home",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onTap: gotoHome,
            ),
          ),
          // settings list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onTap: gotoSettings,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onTap: logout,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
