import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../data/room_providers.dart';
import '../domain/room.dart';

class RoomsScreen extends ConsumerWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(roomsProvider);
    final totalDevices = rooms.fold<int>(0, (sum, r) => sum + r.deviceCount);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Glass app bar
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
                  color: AppColors.onSurfaceVariant,
                ),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                height: 0.5,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
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
                // Header
                Text(
                  'Your Rooms',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '$totalDevices total devices connected',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Rooms list
                ...rooms.map(
                  (room) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: _RoomCard(room: room),
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

class _RoomCard extends StatefulWidget {
  const _RoomCard({required this.room});
  final Room room;

  @override
  State<_RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<_RoomCard> {
  double _scale = 1.0;

  // Room gradient colors and icons for visual variety
  static const _roomConfig = <String, (Color, Color, IconData)>{
    'living-room': (Color(0xFF8B5E3C), Color(0xFFC4956A), Icons.weekend_outlined),
    'bedroom': (Color(0xFF4A6B8A), Color(0xFF7EA8C4), Icons.bed_outlined),
    'kitchen': (Color(0xFF2D4A3E), Color(0xFF5A8A72), Icons.kitchen_outlined),
    'garage': (Color(0xFF4A4A5A), Color(0xFF8A8A9A), Icons.garage_outlined),
    'bathroom': (Color(0xFF2E6B8A), Color(0xFF5AA0C4), Icons.bathtub_outlined),
    'garden': (Color(0xFF2D5A27), Color(0xFF5A8A52), Icons.nature_outlined),
  };

  @override
  Widget build(BuildContext context) {
    final config = _roomConfig[widget.room.id] ??
        (AppColors.primary, AppColors.primaryContainer, Icons.meeting_room_outlined);
    final darkColor = config.$1;
    final lightColor = config.$2;
    final icon = config.$3;
    final hasActive = widget.room.activeCount > 0;

    return GestureDetector(
      onTap: () => context.push('/rooms/${widget.room.id}'),
      onTapDown: (_) => setState(() => _scale = 0.98),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [darkColor, lightColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: darkColor.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Decorative background elements
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),
              Positioned(
                left: -30,
                bottom: 40,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.04),
                  ),
                ),
              ),

              // Large room icon
              Positioned(
                right: 20,
                top: 20,
                child: Icon(
                  icon,
                  size: 80,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),

              // Bottom glass footer
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                    color: Colors.white.withValues(alpha: 0.15),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.room.name,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: hasActive
                                        ? const Color(0xFF34C759)
                                        : Colors.white.withValues(alpha: 0.5),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  hasActive
                                      ? '${widget.room.activeCount} Device${widget.room.activeCount == 1 ? '' : 's'} Active'
                                      : '0 Devices Active',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withValues(alpha: 0.85),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
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
