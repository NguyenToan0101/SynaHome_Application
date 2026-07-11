import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/localization/l10n_extensions.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/services/backend_resolver.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/state_views.dart';
import '../../authentication/presentation/auth_controller.dart';
import '../../devices/data/device_providers.dart';
import '../../devices/domain/device.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(devicesControllerProvider);
    final mode = ref.watch(connectionModeControllerProvider);
    final session = ref.watch(authControllerProvider).session;
    final l10n = context.l10n;
    final date = DateFormat('EEEE, d MMMM').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Syna'),
        actions: [
          IconButton(
            tooltip: l10n.notifications,
            onPressed: () => context.go('/profile/notifications'),
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(devicesControllerProvider.notifier).refresh(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.md,
              AppSpacing.screen,
              AppSpacing.xl,
            ),
            children: [
              _ConnectionBanner(mode: mode),
              const SizedBox(height: AppSpacing.lg),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          date.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                  ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.goodMorning(session?.name ?? 'Alex'),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.wb_sunny_rounded, color: AppColors.primary),
                          SizedBox(width: 4),
                          Text('24C'),
                        ],
                      ),
                      Text('08:45'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              devices.when(
                data: (items) => _DashboardContent(devices: items),
                loading: () => const SizedBox(height: 420, child: LoadingView()),
                error: (error, stackTrace) => SizedBox(
                  height: 420,
                  child: ErrorView(
                    message: error.toString(),
                    onRetry: () =>
                        ref.read(devicesControllerProvider.notifier).load(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardContent extends ConsumerWidget {
  const _DashboardContent({required this.devices});

  final List<Device> devices;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final favorites = devices.where((device) => device.isFavorite).toList();
    final activeCount = devices.where((device) => device.isOn).length;

    if (devices.isEmpty) {
      return EmptyView(message: l10n.emptyTitle);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.hero),
            gradient: const LinearGradient(
              colors: [Colors.white, AppColors.surfaceContainerLow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color(0x1A006E28),
                child: Icon(Icons.verified_user_rounded, color: AppColors.success),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.everythingSecure,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      l10n.activeDevices(activeCount),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.quickScenes.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: AppSpacing.md),
        const _QuickScenes(),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0x330058BC),
                child: Icon(Icons.auto_awesome_rounded, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'Syna AI đã tối ưu hệ thống. Điện năng hôm nay thấp hơn 12% so với tuần trước.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.favoriteDevices.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall),
            TextButton(
              onPressed: () => context.go('/rooms'),
              child: Text(l10n.viewAll),
            ),
          ],
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 560 ? 3 : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: favorites.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.92,
              ),
              itemBuilder: (context, index) =>
                  DeviceCard(device: favorites[index]),
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.recentActivity.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: AppSpacing.md),
        const _ActivityTile(
          icon: Icons.person_rounded,
          title: 'Alex đã về nhà',
          subtitle: '08:30 - Smart Lock',
        ),
        const _ActivityTile(
          icon: Icons.light_mode_rounded,
          title: 'Kích hoạt ngữ cảnh buổi sáng',
          subtitle: '07:00 - Scene',
        ),
        const _ActivityTile(
          icon: Icons.security_rounded,
          title: 'Phát hiện chuyển động sân sau',
          subtitle: '03:12 - Camera',
        ),
      ],
    );
  }
}

class DeviceCard extends ConsumerWidget {
  const DeviceCard({required this.device, super.key});

  final Device device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icon = switch (device.type) {
      DeviceType.light => Icons.lightbulb_rounded,
      DeviceType.thermostat => Icons.ac_unit_rounded,
      DeviceType.lock => Icons.lock_rounded,
      DeviceType.speaker => Icons.speaker_rounded,
      DeviceType.camera => Icons.videocam_rounded,
      DeviceType.fan => Icons.air_rounded,
      DeviceType.sensor => Icons.sensors_rounded,
    };

    return AppCard(
      onTap: () => context.go('/home/devices/${device.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: device.isOn
                    ? const Color(0x1A0058BC)
                    : AppColors.surfaceContainer,
                child: Icon(icon, color: AppColors.primary),
              ),
              Switch.adaptive(
                value: device.isOn,
                onChanged: device.status == DeviceStatus.offline
                    ? null
                    : (value) {
                        ref
                            .read(devicesControllerProvider.notifier)
                            .updateDevice(
                              device.id,
                              DeviceCommand(isOn: value),
                            );
                      },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                device.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                device.subtitle ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
              ),
              if (device.brightness != null) ...[
                const SizedBox(height: AppSpacing.md),
                LinearProgressIndicator(value: device.brightness! / 100),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickScenes extends StatelessWidget {
  const _QuickScenes();

  @override
  Widget build(BuildContext context) {
    final scenes = [
      (Icons.power_settings_new_rounded, 'All Off'),
      (Icons.home_rounded, 'Arrive Home'),
      (Icons.movie_rounded, 'Movie'),
      (Icons.bedtime_rounded, 'Good Night'),
      (Icons.add_rounded, 'Add'),
    ];

    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final scene = scenes[index];
          return Semantics(
            button: true,
            label: scene.$2,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: index == 1
                      ? AppColors.primary
                      : AppColors.surfaceContainerLowest,
                  child: Icon(
                    scene.$1,
                    color: index == 1 ? Colors.white : AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(scene.$2),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.md),
        itemCount: scenes.length,
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.surfaceContainer,
        child: Icon(icon, color: AppColors.onSurfaceVariant),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

class _ConnectionBanner extends StatelessWidget {
  const _ConnectionBanner({required this.mode});

  final ConnectionMode mode;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = switch (mode) {
      ConnectionMode.edge => l10n.localMode,
      ConnectionMode.cloud => l10n.cloudMode,
      ConnectionMode.offline => l10n.offline,
    };
    final icon = switch (mode) {
      ConnectionMode.edge => Icons.router_rounded,
      ConnectionMode.cloud => Icons.cloud_done_rounded,
      ConnectionMode.offline => Icons.cloud_off_rounded,
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
