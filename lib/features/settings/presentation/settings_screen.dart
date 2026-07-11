import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screen),
        children: [
          SwitchListTile.adaptive(
            value: true,
            onChanged: (_) {},
            title: const Text('Use local Edge backend first'),
            secondary: const Icon(Icons.router_rounded),
          ),
          ListTile(
            leading: const Icon(Icons.language_rounded),
            title: const Text('Language'),
            subtitle: const Text('Vietnamese'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy and data'),
            subtitle: const Text('Delete account and clear local data supported'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
