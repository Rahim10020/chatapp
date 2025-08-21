import 'package:chatapp/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void gotoSettings() {
    // fermer le drawer
    Get.back();
    // aller au settings
    Get.offAllNamed('/settings');
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
              final authService = AuthServices();
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
              title: Text("H O M E"),
              leading: Icon(Icons.home),
              onTap: gotoHome,
            ),
          ),
          // settings list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("S E T T I N G S"),
              leading: Icon(Icons.settings),
              onTap: gotoSettings,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
              onTap: logout,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
