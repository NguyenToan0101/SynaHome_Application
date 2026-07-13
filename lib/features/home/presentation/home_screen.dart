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
    final date = DateFormat('EEEE, d MMMM').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          // Glassmorphic App Bar
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            expandedHeight: 0,
            flexibleSpace: _GlassAppBar(
              onNotificationTap: () => context.go('/profile/notifications'),
            ),
            toolbarHeight: 68,
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screen,
                  AppSpacing.sm,
                  AppSpacing.screen,
                  100, // nav bar clearance
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ConnectionBanner(mode: mode),
                    const SizedBox(height: AppSpacing.lg),

                    // Greeting Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                date.toUpperCase(),
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'Good Morning, ${session?.name ?? 'Alex'}',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                  letterSpacing: -0.5,
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.wb_sunny_rounded,
                                  color: AppColors.primary,
                                  size: 22,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '72°F',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              '08:45 AM • Sunny',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Device state / error
                    devices.when(
                      data: (items) => _DashboardContent(devices: items),
                      loading: () =>
                          const SizedBox(height: 420, child: LoadingView()),
                      error: (error, _) => SizedBox(
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
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Glassmorphic App Bar
// ─────────────────────────────────────────────────────────────────────
class _GlassAppBar extends StatelessWidget {
  const _GlassAppBar({required this.onNotificationTap});
  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.7),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screen,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              // Profile avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceContainer,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 22,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              const Text(
                'Lumina',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                  letterSpacing: -0.3,
                ),
              ),
              const Spacer(),
              // Notification button
              GestureDetector(
                onTap: onNotificationTap,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.primary,
                    size: 24,
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

// ─────────────────────────────────────────────────────────────────────
// Dashboard Content
// ─────────────────────────────────────────────────────────────────────
class _DashboardContent extends ConsumerWidget {
  const _DashboardContent({required this.devices});
  final List<Device> devices;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final favorites = devices.where((d) => d.isFavorite).toList();
    final activeCount = devices.where((d) => d.isOn).length;

    if (devices.isEmpty) {
      return EmptyView(message: l10n.emptyTitle);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Security Status Hero Card
        _SecurityHeroCard(activeCount: activeCount),
        const SizedBox(height: AppSpacing.lg),

        // Quick Scenes
        const Text(
          'QUICK SCENES',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _QuickScenes(),
        const SizedBox(height: AppSpacing.lg),

        // AI Optimizer Card
        _LuminaAICard(),
        const SizedBox(height: AppSpacing.lg),

        // Favorite Devices
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'FAVORITE DEVICES',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            TextButton(
              onPressed: () => context.go('/rooms'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'View All',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final cols = constraints.maxWidth > 560 ? 3 : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: favorites.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
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

        // Recent Activity
        const Text(
          'RECENT ACTIVITY',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _ActivityList(),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Security Hero Card
// ─────────────────────────────────────────────────────────────────────
class _SecurityHeroCard extends StatefulWidget {
  const _SecurityHeroCard({required this.activeCount});
  final int activeCount;

  @override
  State<_SecurityHeroCard> createState() => _SecurityHeroCardState();
}

class _SecurityHeroCardState extends State<_SecurityHeroCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFEEEDF3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.hero),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Atmospheric decoration
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            left: -20,
            bottom: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Pulsing green dot indicator
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _pulseCtrl,
                          builder: (context, _) => Container(
                            width: 48 * _pulseCtrl.value,
                            height: 48 * _pulseCtrl.value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondary
                                  .withValues(alpha: 0.15 * (1 - _pulseCtrl.value)),
                            ),
                          ),
                        ),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.secondary.withValues(alpha: 0.1),
                          ),
                          child: Center(
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Everything is secure',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                      Text(
                        '${widget.activeCount} devices active • 0 alerts',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Status pills
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  _StatusPill(label: 'Front Door Locked'),
                  _StatusPill(label: 'Cameras On'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.onSurface,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Quick Scenes
// ─────────────────────────────────────────────────────────────────────
class _QuickScenes extends StatelessWidget {
  const _QuickScenes();

  @override
  Widget build(BuildContext context) {
    const scenes = [
      (Icons.power_settings_new_rounded, 'All Off', false),
      (Icons.home_rounded, 'Arrive Home', true),
      (Icons.movie_rounded, 'Movie Night', false),
      (Icons.bedtime_rounded, 'Good Night', false),
      (Icons.add_rounded, 'Add Scene', false),
    ];

    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: scenes.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final scene = scenes[index];
          return _SceneButton(
            icon: scene.$1,
            label: scene.$2,
            isActive: scene.$3,
          );
        },
      ),
    );
  }
}

class _SceneButton extends StatefulWidget {
  const _SceneButton({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  final IconData icon;
  final String label;
  final bool isActive;

  @override
  State<_SceneButton> createState() => _SceneButtonState();
}

class _SceneButtonState extends State<_SceneButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: widget.isActive
                    ? AppColors.primaryContainer
                    : Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.isActive
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : const Color(0x0A000000),
                    blurRadius: widget.isActive ? 12 : 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                color: widget.isActive ? Colors.white : AppColors.onSurfaceVariant,
                size: 26,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: widget.isActive
                    ? AppColors.onSurface
                    : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Lumina AI Card
// ─────────────────────────────────────────────────────────────────────
class _LuminaAICard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFF2F3034), // inverse-surface
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Stack(
        children: [
          // Purple/blue glow effects
          Positioned(
            right: -30,
            bottom: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.tertiary.withValues(alpha: 0.2),
              ),
            ),
          ),
          Positioned(
            left: -30,
            top: 0,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: Color(0xFFADC6FF), // primary-fixed-dim
                  size: 22,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lumina AI Optimizer',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF1F0F5), // inverse-on-surface
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      'System optimized. Energy usage is 12% lower today compared to last week.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Color(0xFFC1C6D7), // outline-variant
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Device Card
// ─────────────────────────────────────────────────────────────────────
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

    final accentColor = switch (device.type) {
      DeviceType.lock => AppColors.secondary,
      _ => AppColors.primary,
    };

    return AppCard(
      onTap: () => context.go('/home/devices/${device.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon + toggle row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: device.isOn
                      ? accentColor.withValues(alpha: 0.1)
                      : AppColors.surfaceContainer,
                ),
                child: Icon(
                  icon,
                  color: device.isOn ? accentColor : AppColors.onSurfaceVariant,
                  size: 22,
                ),
              ),
              if (device.type == DeviceType.lock)
                Text(
                  device.isOn ? 'LOCKED' : 'UNLOCKED',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: accentColor,
                  ),
                )
              else
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

          // Name + subtitle + type-specific control
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                device.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                device.subtitle ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Type-specific bottom controls
              if (device.type == DeviceType.light && device.brightness != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: device.brightness! / 100,
                    minHeight: 6,
                    backgroundColor: AppColors.surfaceContainer,
                    valueColor: AlwaysStoppedAnimation(accentColor),
                  ),
                )
              else if (device.type == DeviceType.thermostat &&
                  device.temperature != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _TempButton(
                      icon: Icons.remove,
                      onPressed: () {},
                    ),
                    Text(
                      '${device.temperature?.toInt()}°',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    _TempButton(
                      icon: Icons.add,
                      onPressed: () {},
                    ),
                  ],
                )
              else if (device.type == DeviceType.speaker)
                // Sound wave indicator
                Row(
                  children: List.generate(
                    4,
                    (i) => _SoundBar(index: i),
                  ),
                )
              else if (device.type == DeviceType.lock)
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Tap to Unlock',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TempButton extends StatelessWidget {
  const _TempButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Icon(icon, size: 16, color: AppColors.onSurfaceVariant),
      ),
    );
  }
}

class _SoundBar extends StatefulWidget {
  const _SoundBar({required this.index});
  final int index;

  @override
  State<_SoundBar> createState() => _SoundBarState();
}

class _SoundBarState extends State<_SoundBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  static const _heights = [12.0, 16.0, 8.0, 14.0];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400 + widget.index * 80),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minH = _heights[widget.index] * 0.4;
    final maxH = _heights[widget.index];
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: AnimatedBuilder(
        animation: _anim,
        builder: (context, _) => Container(
          width: 3,
          height: minH + (maxH - minH) * _anim.value,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Recent Activity
// ─────────────────────────────────────────────────────────────────────
class _ActivityList extends StatelessWidget {
  const _ActivityList();

  @override
  Widget build(BuildContext context) {
    const activities = [
      (Icons.person_rounded, 'Alex arrived home', '08:30 AM • Smart Lock', false),
      (Icons.light_mode_rounded, 'Morning routine activated', '07:00 AM • Scene', true),
      (Icons.security_rounded, 'Patio motion detected', '03:12 AM • Camera', true),
    ];

    return Column(
      children: activities.asMap().entries.map((entry) {
        final i = entry.key;
        final a = entry.value;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceContainer,
              ),
              child: Icon(
                a.$1,
                size: 20,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            if (i > 0)
              // Vertical connector line
              Container(
                width: 1,
                height: 40,
                color: AppColors.surfaceContainer,
                margin: const EdgeInsets.only(left: 19),
              ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.$2,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      a.$3,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Connection Banner
// ─────────────────────────────────────────────────────────────────────
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
    final color = switch (mode) {
      ConnectionMode.offline => AppColors.error,
      _ => AppColors.primary,
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
          Icon(icon, size: 18, color: color),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
