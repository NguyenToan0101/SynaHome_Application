import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';

class AutomationScreen extends StatefulWidget {
  const AutomationScreen({super.key});

  @override
  State<AutomationScreen> createState() => _AutomationScreenState();
}

class _AutomationScreenState extends State<AutomationScreen> {
  final List<_AutomationRule> _rules = [
    _AutomationRule(
      id: 'sunset',
      title: 'Sunset Routine',
      subtitle: 'Daily • Local Time',
      icon: Icons.wb_twilight_rounded,
      iconColor: AppColors.tertiaryContainer,
      iconTextColor: Colors.white,
      leftLabel: 'IF SUNSET',
      leftValue: 'Close Living Blinds',
      rightLabel: 'STATUS',
      rightValue: 'Active',
      isActive: true,
      showStatusDot: true,
    ),
    _AutomationRule(
      id: 'arrive-home',
      title: 'Arrive Home',
      subtitle: 'Geofence • < 50m',
      icon: Icons.home_work_rounded,
      iconColor: AppColors.primaryContainer,
      iconTextColor: Colors.white,
      leftLabel: 'THEN ACTIONS',
      leftValue: 'Unlock Door & AC 72°F',
      rightLabel: 'FREQUENCY',
      rightValue: '2x Today',
      isActive: true,
      showStatusDot: false,
    ),
  ];

  final List<_QuickScene> _scenes = const [
    _QuickScene(
      name: 'Movie Night',
      deviceCount: 8,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDMi27uI6y9g_0wDJfnJWka8_Nx1V2BAqqKR45R9AR6SeDbKiCNcQKcemA0NjWVgcQ1X3F0P0Aipgw7eyZbxo96mR555atUAof-iYHm1wBM6GHHNvmihitO9I8KxJ32vjBOgUjyXgmNpwvmRBZ92uHaO9P9byytqY6ADL7vAmWdm1a9cBein4amxYzQl_7GLEcltPExr0wxJxmkPL6DNvVWO5C0PHRIxV2Rn6YQJowkehu4hnVSmB7xERlO-Rx6qdkHFwYUiD8kSDE',
    ),
    _QuickScene(
      name: 'Good Night',
      deviceCount: 12,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDfCpPPnIOau7Z1M7jvgN7xGJdt3vaUosuj2g672sqA7gEhfb8omcosmjg__d2qphBthhIQql7O-sxA8dN7s8ofY3vHEFPzkSSEdOtiMcMzrfsNgXYh7n6FWy7zAHoIuzsiwrWZj8aKkeZrEK0RV9X4nbCjC49opQgRiIUjNEcJGDu-XqI523EqvTT4gqDPpZpHPGgu_kSFQaC6ttZHJztJvn5q1tQo8WYNwi0g6q8qec0X_qXmTu3CNxqmEGA9L82erj_llZqIOlI',
    ),
    _QuickScene(
      name: 'Focus Mode',
      deviceCount: 4,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDQmzhmmlIBGEdX7iMmI6ugkORwxTLjxE65GmB3FXT5tRs4NN5x1fv5A_exuuhOZ62h1E-REpc_Ds3cEtv88rk2CKtRIRfo5wbgQMJmXVt7mFYrVsJPxGJi4k_5KqbVwA9mhBg1lrZ5o2qi9nNA4kxoekMM9mWC8i4uKcUv7tKcr-RB9xLcVtmPEUhB4PHlxhAnSa-3xHer26WqkaUe9zy01IHCBT0MnhhtkphoXp6XJK4eTMGS5OGmR5ku5ckhytMg9u-maKc-dsU',
    ),
  ];

  void _toggleRule(String id) {
    setState(() {
      final index = _rules.indexWhere((rule) => rule.id == id);
      _rules[index] = _rules[index].copyWith(
        isActive: !_rules[index].isActive,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.surface.withValues(alpha: 0.7),
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 68,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.onSurfaceVariant,
              ),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            title: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surfaceContainer,
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 20,
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
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.onSurfaceVariant,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screen,
              AppSpacing.lg,
              AppSpacing.screen,
              AppSpacing.xl,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MANAGEMENT',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: AppSpacing.xs),
                          Text(
                            'Automations',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.5,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _CreateNewButton(onPressed: () {}),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // IF-THEN builder
                AppCard(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppRadius.hero),
                    border: Border.all(
                      color: AppColors.outlineVariant.withValues(alpha: 0.3),
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 520;
                      if (isWide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(child: _IfSection()),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xl,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 28,
                                color:
                                    AppColors.outline.withValues(alpha: 0.8),
                              ),
                            ),
                            const Expanded(child: _ThenSection()),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          const _IfSection(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md,
                            ),
                            child: Icon(
                              Icons.arrow_downward_rounded,
                              size: 28,
                              color: AppColors.outline.withValues(alpha: 0.8),
                            ),
                          ),
                          const _ThenSection(),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Active rules
                const Text(
                  'Active Rules',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                ..._rules.map(
                  (rule) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                    child: _RuleCard(
                      rule: rule,
                      onToggle: () => _toggleRule(rule.id),
                    ),
                  ),
                ),

                // Quick scenes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quick Scenes',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: 224,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _scenes.length + 1,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.md),
                    itemBuilder: (context, index) {
                      if (index == _scenes.length) {
                        return const _NewSceneCard();
                      }
                      return _SceneCard(scene: _scenes[index]);
                    },
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateNewButton extends StatefulWidget {
  const _CreateNewButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_CreateNewButton> createState() => _CreateNewButtonState();
}

class _CreateNewButtonState extends State<_CreateNewButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onPressed,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_rounded, color: Colors.white, size: 20),
              SizedBox(width: AppSpacing.sm),
              Text(
                'Create New',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IfSection extends StatelessWidget {
  const _IfSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'IF',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Text(
              'Trigger occurs',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _TriggerTile(icon: Icons.schedule_rounded, label: 'Time'),
        const SizedBox(height: AppSpacing.md),
        _TriggerTile(icon: Icons.near_me_rounded, label: 'Location'),
        const SizedBox(height: AppSpacing.md),
        _TriggerTile(icon: Icons.sensors_rounded, label: 'Device State'),
      ],
    );
  }
}

class _ThenSection extends StatelessWidget {
  const _ThenSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'THEN',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: AppColors.secondary,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Text(
              'Execute action',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _TriggerTile(
          icon: Icons.palette_rounded,
          label: 'Scenes',
          accentColor: AppColors.secondary,
        ),
        const SizedBox(height: AppSpacing.md),
        _TriggerTile(
          icon: Icons.settings_remote_rounded,
          label: 'Control Device',
          accentColor: AppColors.secondary,
        ),
      ],
    );
  }
}

class _TriggerTile extends StatefulWidget {
  const _TriggerTile({
    required this.icon,
    required this.label,
    this.accentColor = AppColors.primary,
  });

  final IconData icon;
  final String label;
  final Color accentColor;

  @override
  State<_TriggerTile> createState() => _TriggerTileState();
}

class _TriggerTileState extends State<_TriggerTile> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.98),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              Icon(widget.icon, color: widget.accentColor, size: 28),
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RuleCard extends StatelessWidget {
  const _RuleCard({required this.rule, required this.onToggle});

  final _AutomationRule rule;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () {},
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.hero),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: rule.isActive ? 1.0 : 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: rule.iconColor,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Icon(
                    rule.icon,
                    color: rule.iconTextColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rule.title,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        rule.subtitle,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: rule.isActive,
                  onChanged: (_) => onToggle(),
                  activeThumbColor: Colors.white,
                  activeTrackColor: AppColors.secondary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _RuleDetail(
                      label: rule.leftLabel,
                      value: rule.leftValue,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 32,
                    color: AppColors.outlineVariant.withValues(alpha: 0.3),
                  ),
                  Expanded(
                    child: rule.showStatusDot
                        ? _RuleStatus(value: rule.rightValue)
                        : _RuleDetail(
                            label: rule.rightLabel,
                            value: rule.rightValue,
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

class _RuleDetail extends StatelessWidget {
  const _RuleDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleStatus extends StatelessWidget {
  const _RuleStatus({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'STATUS',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SceneCard extends StatefulWidget {
  const _SceneCard({required this.scene});

  final _QuickScene scene;

  @override
  State<_SceneCard> createState() => _SceneCardState();
}

class _SceneCardState extends State<_SceneCard> {
  double _scale = 1.0;
  bool _activated = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: () {
        setState(() => _activated = true);
        Future<void>.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _activated = false);
        });
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: SizedBox(
          width: 192,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.hero),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.scene.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: AppColors.surfaceContainer,
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: AppSpacing.md,
                  right: AppSpacing.md,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      _activated
                          ? Icons.check_circle_rounded
                          : Icons.play_circle_outline_rounded,
                      key: ValueKey(_activated),
                      color: _activated
                          ? AppColors.secondary
                          : Colors.white.withValues(alpha: 0.4),
                      size: 28,
                    ),
                  ),
                ),
                Positioned(
                  left: AppSpacing.lg,
                  right: AppSpacing.lg,
                  bottom: AppSpacing.lg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.scene.name,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '${widget.scene.deviceCount} Devices',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NewSceneCard extends StatefulWidget {
  const _NewSceneCard();

  @override
  State<_NewSceneCard> createState() => _NewSceneCardState();
}

class _NewSceneCardState extends State<_NewSceneCard> {
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
        child: Container(
          width: 192,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.hero),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.4),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                size: 32,
                color: AppColors.onSurfaceVariant.withValues(alpha: 0.8),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'New Scene',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AutomationRule {
  const _AutomationRule({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconTextColor,
    required this.leftLabel,
    required this.leftValue,
    required this.rightLabel,
    required this.rightValue,
    required this.isActive,
    required this.showStatusDot,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconTextColor;
  final String leftLabel;
  final String leftValue;
  final String rightLabel;
  final String rightValue;
  final bool isActive;
  final bool showStatusDot;

  _AutomationRule copyWith({bool? isActive}) {
    return _AutomationRule(
      id: id,
      title: title,
      subtitle: subtitle,
      icon: icon,
      iconColor: iconColor,
      iconTextColor: iconTextColor,
      leftLabel: leftLabel,
      leftValue: leftValue,
      rightLabel: rightLabel,
      rightValue: rightValue,
      isActive: isActive ?? this.isActive,
      showStatusDot: showStatusDot,
    );
  }
}

class _QuickScene {
  const _QuickScene({
    required this.name,
    required this.deviceCount,
    required this.imageUrl,
  });

  final String name;
  final int deviceCount;
  final String imageUrl;
}
