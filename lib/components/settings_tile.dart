import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String title;
  final String subtitle;
  final double bbottom;
  final Function()? onTap;

  const SettingsTile({
    super.key,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.title,
    required this.subtitle,
    required this.bbottom,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(bottom: bbottom),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        trailing: Icon(
          trailingIcon,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: onTap,
      ),
    );
  }
}
