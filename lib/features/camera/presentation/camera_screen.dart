import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin {
  bool _showControls = false;
  bool _isPlaying = true;
  late AnimationController _pulseCtrl;

  static const _mainFeedUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBhGLV6cphkaQJHWf_HXbzqowJHIhwkmgFhCpkgPNrxjaDa3hXt-GQceSvX2m5BqrWF-oOCA7PTPwi0UQe0nzfQxGnzdjdIiE-FAbjwkp6o3HNcqqIt1xf0uTQLOlKjenil77Ie6wE5eQd-tTaU0Mjz_aCL3LlCXIzVVp7c93TKQCFfKdE8zMDUQRHDngAWwRbD1n-L5tNGvqx0JFuVWyQYypuColXYzPoIVXrDFgIQxhgfDf7g361jl9zxHVLhbAmyiwYVUFkkOMo';

  static const _feeds = [
    _CameraFeed(
      name: 'Patio',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCQ1_x1G4HbAl31FfgYxdVQPILGDemUvcGgOW59UW61He4TmbKlIRO-Mg3IP_BFU1TUOOpxF0Uer-XMjtPTSBVVTfyvmfsv3kTl25loH_RLGKDrJDMrxHaobJSQAFCp0CDYLcGXO4bjxJAJ_aFV5kmbcY9mg-082SAkC5cEqEleYI7GjtElFEmm_XzF-0RYKk465ateON5AZF1teI1iVWR1rzL7s2jJEE_iKEi2pEmzosH1Fvw6nUiq_e4nTwNuq7qQgSlpbuzaMNc',
    ),
    _CameraFeed(
      name: 'Driveway',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDsz1-oW2GPeI1nHd1El3NfLlycXWA4YhdQn6iiTVp1IOxjeaQJbf1WQSQfP26R8dV-wBR8IKI7JZFEgpS0aw2_JwRyMf9BFGX-kVB3VhG_wAYkVV9E5luVWgqrZWidGhOeRYtKEpitHk3YJA8E-BAIkXCLLju73qN6-8ny32XVecuOMgqMrrAhKPD4lYXAbiEvUoTOVrgzTeBaFS9Zh-UuxdoYZY39J9wWOYr_FkKN7atPVTIXYpSnsEK8c_Dj_hvleLQpGWyK95E',
    ),
    _CameraFeed(
      name: 'Kitchen',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCGT7VC2HBdfPfgW8zLvmWOEp_q3uTQctuNQf3LcuzgaYs3TrLUNk1x6HZAaDbWdPkKs-YDE8aLelpp1y1f1DRv0tz1ejnyvh8v5WZIr8CA7S5TA5_DT4ZV1Wz7m4JuEACklSZM9O4yOKVv_Z6xToe7GgXXJ8hLuVaepF_I_JroTuVXOhzceX5NbmSUqGX_wcGSPWb160RF0sW2LAm1xPAEqm6x1rHTmXlzmiLYo9y3t66NNg7NFe3MUci9sTsYQlyQqMs717KfMrM',
      wide: true,
    ),
  ];

  static const _historyEvents = [
    _HistoryEvent(
      title: 'Package Delivery',
      location: 'Front Door',
      time: '10:42 AM',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAJmjg6uhhnkWi0nXsD-3c-Bn9-I2MueacHSVGbz5MoRJ85DdfKyOiX6IvyVvtTKdJZboKQsFqKil2plRUCqMzFkyIUgG-ZpyxKEeoxcgdEVnJVjYHyo5HSxoTPLGz-3RoX3utWjyUiU19VBaXw_e3VXFXsBKGa7QWDKfV-CRBet2mFHILnAWvGe-peP_jo4U_uD9PGpIdo9zFybotne70gJSUeNV4WD8AAVk7ZGC7K9ay-iQWAwDGRdoJNty1PZ1Ag-uJGrRV-siU',
    ),
    _HistoryEvent(
      title: 'Vehicle Detected',
      location: 'Driveway',
      time: '09:15 AM',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBVyJi4El7zDUE13_gjG1D6ceBYSYG8hyl4ttIlqECfzWbHlns6zlkJnw5s3yF8pfF9lGOzia1eA97NR20G9dfAuDvvS_bURe0ylZ-cdSuZO9KVs_rQE3kBtzb8RnbJNQsTtBBwqv5rXR4o2WkAu37NabnyH4o3_XbVfKerEZAXqtxBX5nIuTsS38nLRsLbxkdkumN8ES6AcMod-ExGmA-yEec8y6tuaNUOBYFRs7v49pDdPhNsju07CtGkW8m7lhyjr2_vthZ74N8',
      highlighted: true,
    ),
    _HistoryEvent(
      title: 'Pet Movement',
      location: 'Patio',
      time: '03:22 AM',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBK0bX2moALZ8Ls8ByJx5N-yWA3N8xBwc7Qny2QXfFYJPfnDQrbcMPhzeiYiM6rREkey3z3HmB_NZ-vX91lgPhNYIgG4v2W4rZQzycGDGeAAoZlZKuzoADCPNCgieJ0prxa8yqnxyjMzQXbwALzGZZg_A58R5Q1I6hIWBoVuN1DbbkhGQvDz58tnVBsn8DyeQ__h1MlPP8mMIhcV-AiI404NRXrue48e7DWdp-WAgOshKB2VuluVwkOPzKMzyVVUs3AMD4Va2c0TVc',
    ),
    _HistoryEvent(
      title: 'General Activity',
      location: 'Kitchen',
      time: 'Yesterday',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDyqO20ARNsS-gSeO_Fodyq_lSuGRzGXx9y9L7IlQiJY7gPAUy8RSpeJJgBd_Vru2pcUNEtzs833gT4uv9WoUf_sdIB87-6swwUiz_M50c9zmj7-_oQMJYC9OPu-GJhn2S6oqQyPTbgo9ef4JFKD3QVWgfh3snsCzJ13LGldaFXQstWJHSUFz219y4mw198nMV7nXkEvUWnaoIJ0GISqLnw5TK9lNLeDiDwGjiEnIaDbKB7GsBQFGouinshkE5TWwyVGT1_m2qM2Eo',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
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
            title: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surfaceContainer,
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
                  color: AppColors.primary,
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
              100,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _MainFeedPlayer(
                  imageUrl: _mainFeedUrl,
                  showControls: _showControls,
                  isPlaying: _isPlaying,
                  pulseAnimation: _pulseCtrl,
                  onTap: () => setState(() => _showControls = !_showControls),
                  onPlayPause: () => setState(() => _isPlaying = !_isPlaying),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Quick actions
                Row(
                  children: [
                    Expanded(
                      child: _QuickActionButton(
                        icon: Icons.motion_photos_on_outlined,
                        label: 'Motion',
                        hoverColor: AppColors.primaryContainer,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _QuickActionButton(
                        icon: Icons.videocam_outlined,
                        label: 'Record',
                        hoverColor: AppColors.error,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _QuickActionButton(
                        icon: Icons.mic_outlined,
                        label: 'Talk',
                        hoverColor: AppColors.primaryContainer,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _QuickActionButton(
                        icon: Icons.photo_camera_outlined,
                        label: 'Snapshot',
                        hoverColor: AppColors.primaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                const Text(
                  'Active Feeds',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1,
                  ),
                  itemCount: _feeds.length,
                  itemBuilder: (context, index) {
                    final feed = _feeds[index];
                    return _FeedTile(feed: feed);
                  },
                ),
                const SizedBox(height: AppSpacing.xl),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'History',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      label: const Text(
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
                  height: 160,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _historyEvents.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.md),
                    itemBuilder: (context, index) {
                      return _HistoryTile(event: _historyEvents[index]);
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

class _MainFeedPlayer extends StatelessWidget {
  const _MainFeedPlayer({
    required this.imageUrl,
    required this.showControls,
    required this.isPlaying,
    required this.pulseAnimation,
    required this.onTap,
    required this.onPlayPause,
  });

  final String imageUrl;
  final bool showControls;
  final bool isPlaying;
  final Animation<double> pulseAnimation;
  final VoidCallback onTap;
  final VoidCallback onPlayPause;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => const ColoredBox(
                  color: Colors.black,
                ),
              ),

              // Live badge
              Positioned(
                top: AppSpacing.md,
                left: AppSpacing.md,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      color: Colors.black.withValues(alpha: 0.4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedBuilder(
                            animation: pulseAnimation,
                            builder: (context, child) {
                              return Opacity(
                                opacity: 0.5 + pulseAnimation.value * 0.5,
                                child: child,
                              );
                            },
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          const Text(
                            'LIVE • 4K ULTRA HD',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.6,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Camera name badge
              Positioned(
                top: AppSpacing.md,
                right: AppSpacing.md,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      color: Colors.black.withValues(alpha: 0.4),
                      child: const Text(
                        'Front Door',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Playback controls
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: showControls ? 1.0 : 0.0,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _PlaybackButton(
                        icon: Icons.replay_10_rounded,
                        size: 56,
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      _PlaybackButton(
                        icon: isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 80,
                        onTap: onPlayPause,
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      _PlaybackButton(
                        icon: Icons.forward_10_rounded,
                        size: 56,
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom controls
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _GlassControlButton(
                          icon: Icons.volume_up_rounded,
                        ),
                        _GlassControlButton(
                          icon: Icons.fullscreen_rounded,
                        ),
                      ],
                    ),
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

class _PlaybackButton extends StatefulWidget {
  const _PlaybackButton({
    required this.icon,
    required this.size,
    this.onTap,
  });

  final IconData icon;
  final double size;
  final VoidCallback? onTap;

  @override
  State<_PlaybackButton> createState() => _PlaybackButtonState();
}

class _PlaybackButtonState extends State<_PlaybackButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.9),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: widget.size > 60 ? 0.3 : 0.2,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: widget.size * 0.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassControlButton extends StatelessWidget {
  const _GlassControlButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatefulWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.hoverColor,
  });

  final IconData icon;
  final String label;
  final Color hoverColor;

  @override
  State<_QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<_QuickActionButton> {
  double _scale = 1.0;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() {
        _scale = 0.95;
        _pressed = true;
      }),
      onTapUp: (_) => setState(() {
        _scale = 1.0;
        _pressed = false;
      }),
      onTapCancel: () => setState(() {
        _scale = 1.0;
        _pressed = false;
      }),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: _pressed ? widget.hoverColor : AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                widget.icon,
                color: _pressed ? Colors.white : AppColors.onSurface,
                size: 24,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _pressed ? Colors.white : AppColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedTile extends StatefulWidget {
  const _FeedTile({required this.feed});

  final _CameraFeed feed;

  @override
  State<_FeedTile> createState() => _FeedTileState();
}

class _FeedTileState extends State<_FeedTile> {
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.feed.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const ColoredBox(
                    color: AppColors.surfaceContainer,
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.1),
                  ),
                ),
                Positioned(
                  top: AppSpacing.sm,
                  left: AppSpacing.sm,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs + 2,
                          vertical: 2,
                        ),
                        color: Colors.black.withValues(alpha: 0.3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.secondary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.feed.name.toUpperCase(),
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.event});

  final _HistoryEvent event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: event.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const ColoredBox(
                      color: AppColors.surfaceContainer,
                    ),
                  ),
                  if (event.highlighted)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                    ),
                  Positioned(
                    right: AppSpacing.xs,
                    bottom: AppSpacing.xs,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        event.time,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            event.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
          ),
          Text(
            event.location,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _CameraFeed {
  const _CameraFeed({
    required this.name,
    required this.imageUrl,
    this.wide = false,
  });

  final String name;
  final String imageUrl;
  final bool wide;
}

class _HistoryEvent {
  const _HistoryEvent({
    required this.title,
    required this.location,
    required this.time,
    required this.imageUrl,
    this.highlighted = false,
  });

  final String title;
  final String location;
  final String time;
  final String imageUrl;
  final bool highlighted;
}
