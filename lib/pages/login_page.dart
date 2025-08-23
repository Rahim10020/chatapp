import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // login method
  void login() async {
    // afficher un loader lors du loadage
    showDialog(
      context: Get.context!,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // instance of auth service
    final authService = AuthService();
    // try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );

      // fermeture du loader
      if (Get.isDialogOpen!) Get.back();
    }
    // catch any errors
    catch (e) {
      // fermeture du loader
      if (Get.isDialogOpen!) Get.back();
      Get.snackbar(
        "Erreur de connexion",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.message,
              size: 50,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(height: 50),
            // welcome message
            Text(
              "Welcome back! you've been missed",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 30),
            // email textfield
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
              focusNode: null,
            ),

            const SizedBox(height: 20),
            // password textfield
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
              focusNode: null,
            ),
            const SizedBox(height: 40),
            // login button
            MyButton(login: login, text: "Login"),
            const SizedBox(height: 20),
            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Get.offNamed('/register'),
                  child: Text(
                    "Register now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
