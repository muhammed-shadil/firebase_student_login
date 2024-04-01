import 'package:flutter/material.dart';

class List1 extends StatelessWidget {
  const List1({super.key, required this.title, required this.subtitle, required this.icon});
  final String title;
  final String subtitle;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 16),
      ),
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 206, 206, 206),
        child: icon,
      ),
    );
    ;
  }
}
