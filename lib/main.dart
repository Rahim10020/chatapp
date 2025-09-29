import 'package:chatapp/pages/blocked_users_page.dart';
import 'package:chatapp/pages/light_dark_page.dart';
import 'package:chatapp/pages/profil_page.dart';
import 'package:chatapp/services/auth/auth_gate.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/pages/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialisation de firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // initialisation du controller de theme
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthGate(),
          getPages: [
            GetPage(name: '/login', page: () => LoginPage()),
            GetPage(name: '/register', page: () => RegisterPage()),
            GetPage(name: '/home', page: () => HomePage()),
            GetPage(name: '/settings', page: () => SettingsPage()),
            // GetPage(name: '/chat-page', page: () => ChatPage()),
            GetPage(name: '/light-dark', page: () => LightDarkPage()),
            GetPage(name: '/profil', page: () => ProfilPage()),
            GetPage(name: '/blocked-users', page: () => BlockedUsersPage()),
            // GetPage(name: '/about', page: () => AboutPage()),
          ],
          theme: themeController.currentTheme,
          themeMode: themeController.themeMode,
        );
      },
    );
  }
}
