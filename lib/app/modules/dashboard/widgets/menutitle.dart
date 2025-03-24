import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isCollapsed;
  final VoidCallback onTap;

  const MenuTile({
    required this.icon,
    required this.title,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: isCollapsed ? null : Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}