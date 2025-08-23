import 'package:chatapp/pages/light_dark_page.dart';
import 'package:chatapp/services/auth/auth_gate.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/pages/settings_page.dart';
import 'package:chatapp/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      ],
      theme: lightMode,
    );
  }
}
