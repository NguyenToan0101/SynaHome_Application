import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface.withValues(alpha: 0.7),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Mark All Read',
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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.lg,
          AppSpacing.screen,
          100,
        ),
        children: [
          // Security Alerts section
          _SectionHeader(title: 'Security Alerts', count: 2),
          const SizedBox(height: AppSpacing.sm),
          _NotificationTile(
            icon: Icons.videocam_rounded,
            iconColor: AppColors.error,
            iconBg: AppColors.error.withValues(alpha: 0.1),
            title: 'Patio motion detected',
            subtitle: '03:12 AM • Camera',
            tag: 'Alert',
            tagColor: AppColors.error,
            isUnread: true,
          ),
          _NotificationTile(
            icon: Icons.lock_open_rounded,
            iconColor: AppColors.warning,
            iconBg: AppColors.warning.withValues(alpha: 0.1),
            title: 'Door left unlocked',
            subtitle: '11:40 PM • Main Entrance',
            tag: 'Warning',
            tagColor: AppColors.warning,
            isUnread: true,
          ),

          const SizedBox(height: AppSpacing.lg),

          // Device Alerts
          _SectionHeader(title: 'Device Alerts', count: 2),
          const SizedBox(height: AppSpacing.sm),
          const _NotificationTile(
            icon: Icons.battery_alert_rounded,
            iconColor: AppColors.tertiary,
            iconBg: Color(0x1A894D00),
            title: 'Office Fan battery low',
            subtitle: '09:20 AM • Office Fan',
            tag: 'Low Battery',
            tagColor: AppColors.tertiary,
            isUnread: false,
          ),
          const _NotificationTile(
            icon: Icons.wifi_off_rounded,
            iconColor: AppColors.outline,
            iconBg: AppColors.surfaceContainer,
            title: 'Office Fan offline',
            subtitle: '08:55 AM • Office Fan',
            tag: 'Offline',
            tagColor: AppColors.outline,
            isUnread: false,
          ),

          const SizedBox(height: AppSpacing.lg),

          // Automations
          _SectionHeader(title: 'Completed Automations', count: 3),
          const SizedBox(height: AppSpacing.sm),
          const _NotificationTile(
            icon: Icons.auto_awesome_rounded,
            iconColor: AppColors.secondary,
            iconBg: Color(0x1A006E28),
            title: 'Morning Routine activated',
            subtitle: '07:00 AM • Scene',
            tag: 'Automation',
            tagColor: AppColors.secondary,
            isUnread: false,
          ),
          const _NotificationTile(
            icon: Icons.home_rounded,
            iconColor: AppColors.primary,
            iconBg: Color(0x1A0058BC),
            title: 'Arrive Home scene activated',
            subtitle: '08:30 AM • Smart Lock',
            tag: 'Automation',
            tagColor: AppColors.primary,
            isUnread: false,
          ),
          const _NotificationTile(
            icon: Icons.bedtime_rounded,
            iconColor: Color(0xFF6750A4),
            iconBg: Color(0x1A6750A4),
            title: 'Good Night scene completed',
            subtitle: 'Yesterday • 10:30 PM • Scene',
            tag: 'Automation',
            tagColor: Color(0xFF6750A4),
            isUnread: false,
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
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            '$count',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
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
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.tagColor,
    this.isUnread = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String tag;
  final Color tagColor;
  final bool isUnread;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: isUnread
            ? Colors.white.withValues(alpha: 0.8)
            : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isUnread
              ? AppColors.outlineVariant.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.3),
        ),
        boxShadow: isUnread
            ? [
                const BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 12,
                  offset: Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBg,
              ),
              child: Icon(icon, color: iconColor, size: 22),
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
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: isUnread
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: tagColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: tagColor,
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
