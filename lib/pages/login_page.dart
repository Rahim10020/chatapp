import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            ),

            const SizedBox(height: 20),
            // password textfield
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 40),
            // login button
            MyButton(login: () => {}, text: "Login"),
            const SizedBox(height: 20),
            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => {},
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
