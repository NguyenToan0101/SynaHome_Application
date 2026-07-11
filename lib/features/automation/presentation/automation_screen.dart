import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';

class AutomationScreen extends StatelessWidget {
  const AutomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rules = [
      'IF motion detected THEN turn patio camera on',
      'IF 22:30 THEN activate Good Night',
      'IF nobody home THEN lock main entrance',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Automation')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.screen),
        itemCount: rules.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) => AppCard(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schema_rounded),
            title: Text(rules[index]),
            trailing: Switch.adaptive(value: true, onChanged: (_) {}),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded),
        label: const Text('Rule'),
      ),
    );
  }
}
