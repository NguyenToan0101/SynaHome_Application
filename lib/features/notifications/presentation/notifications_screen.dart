import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.security_rounded),
            title: Text('Patio motion detected'),
            subtitle: Text('03:12 - Camera'),
          ),
          ListTile(
            leading: Icon(Icons.lock_rounded),
            title: Text('Front door locked'),
            subtitle: Text('08:32 - Main Entrance'),
          ),
        ],
      ),
    );
  }
}
