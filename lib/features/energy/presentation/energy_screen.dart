import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../devices/data/device_providers.dart';

class EnergyScreen extends ConsumerWidget {
  const EnergyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(devicesControllerProvider).valueOrNull ?? [];
    final total = devices.fold<double>(
      0,
      (sum, device) => sum + (device.energyWatts ?? 0),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Energy')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screen),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current load', style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '${total.toStringAsFixed(1)} W',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const LinearProgressIndicator(value: .62),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final device in devices)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.bolt_rounded, color: AppColors.primary),
              title: Text(device.name),
              trailing: Text('${(device.energyWatts ?? 0).toStringAsFixed(1)} W'),
            ),
        ],
      ),
    );
  }
}
