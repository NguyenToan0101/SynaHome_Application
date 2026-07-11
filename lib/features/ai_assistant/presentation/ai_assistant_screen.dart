import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';

class AiAssistantScreen extends StatelessWidget {
  const AiAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Assistant')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screen),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Syna AI Optimizer',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                const Text(
                  'Energy usage is trending lower. Bedroom AC can move to Eco mode after 23:00.',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.mic_rounded),
            label: const Text('Voice command'),
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: () => context.push('/automation'),
            icon: const Icon(Icons.auto_awesome_rounded),
            label: const Text('Open automations'),
          ),
        ],
      ),
    );
  }
}
