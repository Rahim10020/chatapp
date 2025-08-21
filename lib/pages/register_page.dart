import 'package:chatapp/auth/auth_services.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // create user function
  void register() async {
    // check if the passwords are correct
    if (_passwordController.text != _confirmPasswordController.text) {
      Get.snackbar(
        "Erreur",
        "Les mots de passe ne correspondent pas",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // show loader when creating user
    showDialog(
      context: Get.context!,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // instance of auth services to create user
    final authServices = AuthServices();

    // try creating the user
    try {
      await authServices.createUserWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );

      // fermeture du loader (car la creation est deja terminee)
      if (Get.isDialogOpen!) Get.back();

      // catch any errors
    } on FirebaseAuthException catch (e) {
      // fermeture du loader (car il y a eu une erreur)
      if (Get.isDialogOpen!) Get.back();
      Get.snackbar(
        "Erreur lors de la creation de l'utilisateur",
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
              "Let's create an account for you!",
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
            ),

            const SizedBox(height: 20),
            // password textfield
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 20),
            // password textfield
            MyTextField(
              hintText: "Confirm password",
              obscureText: true,
              controller: _confirmPasswordController,
            ),
            const SizedBox(height: 40),
            // login button
            MyButton(login: register, text: "Register"),
            const SizedBox(height: 20),
            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Get.offNamed('/login'),
                  child: Text(
                    "Login now",
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
