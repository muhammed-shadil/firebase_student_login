import 'package:flutter/material.dart';

class List1 extends StatelessWidget {
  const List1({super.key, required this.title, required this.subtitle, required this.icon, this.icon2});
  final String title;
  final String subtitle;
  final IconButton? icon2;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(trailing: icon2,
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
