import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/localization/l10n_extensions.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../data/device_providers.dart';
import '../domain/device.dart';

class DeviceDetailScreen extends ConsumerWidget {
  const DeviceDetailScreen({required this.deviceId, super.key});

  final String deviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(devicesControllerProvider).valueOrNull ?? [];
    final device = devices.firstWhere((item) => item.id == deviceId);
    final controller = ref.read(devicesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: [
          IconButton(
            tooltip: context.l10n.notifications,
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screen),
          children: [
            _TemperatureDial(
              value: device.temperature ?? 20,
              onChanged: (value) {
                controller.updateDevice(
                  device.id,
                  DeviceCommand(temperature: value),
                );
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: AppCard(
                    child: _ControlTile(
                      icon: Icons.power_settings_new_rounded,
                      label: 'Power',
                      value: device.isOn ? 'Active' : 'Off',
                      trailing: Switch.adaptive(
                        value: device.isOn,
                        onChanged: (value) => controller.updateDevice(
                          device.id,
                          DeviceCommand(isOn: value),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                const Expanded(
                  child: AppCard(
                    child: _ControlTile(
                      icon: Icons.calendar_today_rounded,
                      label: 'Schedule',
                      value: '4 events',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _ControlHeader(label: 'Fan speed', icon: Icons.air),
                  const SizedBox(height: AppSpacing.md),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'auto', label: Text('Auto')),
                      ButtonSegment(value: 'low', label: Text('Low')),
                      ButtonSegment(value: 'med', label: Text('Med')),
                      ButtonSegment(value: 'high', label: Text('High')),
                    ],
                    selected: const {'auto'},
                    onSelectionChanged: (_) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _ControlHeader(
                    label: 'Temperature history',
                    icon: Icons.show_chart_rounded,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (final value in [
                          .35,
                          .45,
                          .55,
                          .70,
                          .65,
                          .80,
                          .75,
                          .50,
                          .55,
                          .90,
                          .70,
                          .40,
                        ])
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: FractionallySizedBox(
                                heightFactor: value,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors.primary
                                        .withValues(alpha: value),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TemperatureDial extends StatelessWidget {
  const _TemperatureDial({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox.square(
          dimension: 260,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: (value - 16) / 14,
                strokeWidth: 12,
                color: AppColors.primary,
                backgroundColor: AppColors.surfaceContainerHighest,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$value',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const Text('C'),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton.filledTonal(
              tooltip: 'Decrease temperature',
              onPressed: () => onChanged((value - 1).clamp(16, 30).toInt()),
              icon: const Icon(Icons.remove_rounded),
            ),
            const Text('Tap to adjust target'),
            IconButton.filledTonal(
              tooltip: 'Increase temperature',
              onPressed: () => onChanged((value + 1).clamp(16, 30).toInt()),
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
      ],
    );
  }
}

class _ControlTile extends StatelessWidget {
  const _ControlTile({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: AppColors.primary),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(label.toUpperCase(), style: Theme.of(context).textTheme.labelSmall),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _ControlHeader extends StatelessWidget {
  const _ControlHeader({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label.toUpperCase(), style: Theme.of(context).textTheme.labelSmall),
        Icon(icon, color: AppColors.onSurfaceVariant),
      ],
    );
  }
}
