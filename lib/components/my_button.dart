import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? login;
  final String text;
  const MyButton({super.key, required this.login, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        onPressed: login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
