// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({
    Key? key,
    required this.message1,
    required this.message2,
  }) : super(key: key);
  final String message1;
  final String message2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 93, 201, 173),
        title: const Text("Notification's"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: const Color.fromARGB(255, 204, 205, 205),
              title: Text(message1),
              subtitle: Text(message2),
              leading: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.notifications_active_outlined),
              ),
            ),
          )
        ],
      ),
    );
  }
}
