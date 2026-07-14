import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/l10n_extensions.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/glass_tokens.dart';
import '../../../core/widgets/glass/glass.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mint = isDark ? AppColors.auroraMint : AppColors.auroraMintOnLight;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          GlassAppBar(
            title: l10n.notifications,
            onBack: () => context.pop(),
            actions: [
              GlassCard(
                onTap: () {},
                radius: AppRadius.pill,
                blur: GlassTokens.blurSm,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                semanticLabel: l10n.markAllRead,
                child: Text(
                  l10n.markAllRead,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screen,
                AppSpacing.lg,
                AppSpacing.screen,
                AppSpacing.navClearance,
              ),
              children: [
                _SectionHeader(title: l10n.securityAlerts, count: 2),
                const SizedBox(height: AppSpacing.sm),
                _NotificationTile(
                  icon: Icons.videocam_rounded,
                  color: AppColors.auroraError,
                  title: l10n.notifPatioMotion,
                  subtitle: '03:12 • Camera',
                  tag: l10n.tagAlert,
                  isUnread: true,
                ),
                _NotificationTile(
                  icon: Icons.lock_open_rounded,
                  color: AppColors.auroraWarning,
                  title: l10n.notifDoorUnlocked,
                  subtitle: '23:40 • Main Entrance',
                  tag: l10n.tagWarning,
                  isUnread: true,
                ),
                const SizedBox(height: AppSpacing.lg),

                _SectionHeader(title: l10n.deviceAlerts, count: 2),
                const SizedBox(height: AppSpacing.sm),
                _NotificationTile(
                  icon: Icons.battery_alert_rounded,
                  color: AppColors.auroraWarning,
                  title: l10n.notifBatteryLow,
                  subtitle: '09:20 • Office Fan',
                  tag: l10n.tagLowBattery,
                ),
                _NotificationTile(
                  icon: Icons.wifi_off_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  title: l10n.notifDeviceOffline,
                  subtitle: '08:55 • Office Fan',
                  tag: l10n.tagOffline,
                ),
                const SizedBox(height: AppSpacing.lg),

                _SectionHeader(title: l10n.completedAutomations, count: 3),
                const SizedBox(height: AppSpacing.sm),
                _NotificationTile(
                  icon: Icons.auto_awesome_rounded,
                  color: mint,
                  title: l10n.notifMorningRoutine,
                  subtitle: '07:00 • Scene',
                  tag: l10n.tagAutomation,
                ),
                _NotificationTile(
                  icon: Icons.home_rounded,
                  color: theme.colorScheme.primary,
                  title: l10n.notifArriveHome,
                  subtitle: '08:30 • Smart Lock',
                  tag: l10n.tagAutomation,
                ),
                _NotificationTile(
                  icon: Icons.bedtime_rounded,
                  color: AppColors.orbViolet,
                  title: l10n.notifGoodNight,
                  subtitle: '22:30 • Scene',
                  tag: l10n.tagAutomation,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.count});
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Text(
            '$count',
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 11,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.tag,
    this.isUnread = false,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String tag;
  final bool isUnread;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: GlassContainer(
        radius: AppRadius.card,
        active: isUnread,
        blur: GlassTokens.blurSm,
        padding: const EdgeInsets.all(AppSpacing.md),
        shadows: isUnread ? GlassTokens.glow(color, intensity: 0.2) : null,
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.15),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontSize: 15,
                            fontWeight: isUnread
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primary,
                            boxShadow: GlassTokens.glow(
                              theme.colorScheme.primary,
                              intensity: 0.6,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.55,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs + 2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      tag,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 11,
                        color: color,
                      ),
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
