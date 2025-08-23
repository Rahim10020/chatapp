import 'package:flutter/material.dart';

class LightDarkPage extends StatelessWidget {
  const LightDarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Light/Dark"),
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(11),
            ),
          ),
        ],
      ),
    );
  }
}
