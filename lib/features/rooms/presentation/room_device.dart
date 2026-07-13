import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';

class RoomDeviceScreen extends StatefulWidget {
  const RoomDeviceScreen({required this.roomId, super.key});

  final String roomId;

  @override
  State<RoomDeviceScreen> createState() => _RoomDeviceScreenState();
}

class _RoomDeviceScreenState extends State<RoomDeviceScreen> {
  static const _livingRoomBg =
      'stitch_syna_home_systems/room_device/livingroom_devices/'
      'premium_hyper_realistic_3d_render_of_a_luxury_modern_living_room_at_night/'
      'screen.png';

  static const _categories = [
    'All',
    'Lighting',
    'Climate',
    'Cleaning',
    'Entertainment',
    'Security',
  ];

  String _selectedCategory = 'All';
  String _searchQuery = '';

  late List<_RoomDeviceItem> _devices;

  @override
  void initState() {
    super.initState();
    _devices = _livingRoomDevices;
  }

  static const _livingRoomDevices = [
    _RoomDeviceItem(
      id: 'ceiling-light',
      name: 'Ceiling Light',
      category: 'Lighting',
      imageAsset:
          'stitch_syna_home_systems/room_device/livingroom_devices/celling light.png',
      isOn: true,
      statusLabel: '100%',
    ),
    _RoomDeviceItem(
      id: 'pendant-light',
      name: 'Pendant Light',
      category: 'Lighting',
      imageAsset:
          'stitch_syna_home_systems/room_device/livingroom_devices/pendant light.png',
      isOn: true,
      statusLabel: '80%',
    ),
    _RoomDeviceItem(
      id: 'air-conditioner',
      name: 'Air Conditioner',
      category: 'Climate',
      imageAsset:
          'stitch_syna_home_systems/room_device/livingroom_devices/Air conditioner.png',
      isOn: true,
      statusLabel: '23°C',
    ),
    _RoomDeviceItem(
      id: 'ceiling-fan',
      name: 'Ceiling Fan',
      category: 'Climate',
      imageAsset:
          'stitch_syna_home_systems/room_device/livingroom_devices/fan.jpg',
      isOn: true,
      statusLabel: '84%',
    ),
  ];

  List<_RoomDeviceItem> get _filteredDevices {
    return _devices.where((device) {
      final matchesCategory = _selectedCategory == 'All' ||
          device.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          device.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  int get _activeCount => _devices.where((d) => d.isOn).length;

  void _toggleDevice(String id) {
    setState(() {
      _devices = _devices
          .map(
            (d) => d.id == id ? d.copyWith(isOn: !d.isOn) : d,
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final roomName = widget.roomId == 'living-room'
        ? 'Living Room'
        : widget.roomId.replaceAll('-', ' ').split(' ').map(
              (word) =>
                  '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
            ).join(' ');

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Cinematic background
          Image.asset(
            _livingRoomBg,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  Colors.black.withValues(alpha: 0.6),
                  Colors.black.withValues(alpha: 0.9),
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                _RoomDeviceHeader(
                  title: roomName,
                  subtitle: '${_devices.length} Devices • $_activeCount on',
                  onBack: () => context.pop(),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.screen,
                          AppSpacing.md,
                          AppSpacing.screen,
                          0,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: _GlassSearchBar(
                            onChanged: (value) =>
                                setState(() => _searchQuery = value),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 44,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.screen,
                              vertical: AppSpacing.sm,
                            ),
                            itemCount: _categories.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: AppSpacing.sm),
                            itemBuilder: (context, index) {
                              final category = _categories[index];
                              final isActive = _selectedCategory == category;
                              return GestureDetector(
                                onTap: () => setState(
                                  () => _selectedCategory = category,
                                ),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.lg,
                                    vertical: AppSpacing.sm,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? Colors.white.withValues(alpha: 0.9)
                                        : Colors.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(999),
                                    border: isActive
                                        ? null
                                        : Border.all(
                                            color: Colors.white
                                                .withValues(alpha: 0.1),
                                          ),
                                  ),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: isActive
                                          ? AppColors.onSurface
                                          : Colors.white
                                              .withValues(alpha: 0.8),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.screen,
                          AppSpacing.md,
                          AppSpacing.screen,
                          100,
                        ),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: AppSpacing.md,
                            crossAxisSpacing: AppSpacing.md,
                            childAspectRatio: 3 / 4,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final device = _filteredDevices[index];
                              return _GlassDeviceCard(
                                device: device,
                                onToggle: () => _toggleDevice(device.id),
                              );
                            },
                            childCount: _filteredDevices.length,
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
    );
  }
}

class _RoomDeviceItem {
  const _RoomDeviceItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imageAsset,
    required this.isOn,
    required this.statusLabel,
  });

  final String id;
  final String name;
  final String category;
  final String imageAsset;
  final bool isOn;
  final String statusLabel;

  _RoomDeviceItem copyWith({bool? isOn}) {
    return _RoomDeviceItem(
      id: id,
      name: name,
      category: category,
      imageAsset: imageAsset,
      isOn: isOn ?? this.isOn,
      statusLabel: statusLabel,
    );
  }
}

class _RoomDeviceHeader extends StatelessWidget {
  const _RoomDeviceHeader({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  final String title;
  final String subtitle;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screen,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          _GlassIconButton(
            icon: Icons.arrow_back_rounded,
            onTap: onBack,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          _GlassIconButton(
            icon: Icons.more_horiz_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
        ),
      ),
    );
  }
}

class _GlassSearchBar extends StatelessWidget {
  const _GlassSearchBar({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                color: Colors.white.withValues(alpha: 0.4),
                size: 22,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextField(
                  onChanged: onChanged,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: 'Search device...',
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Icon(
                Icons.filter_list_rounded,
                color: Colors.white.withValues(alpha: 0.6),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassDeviceCard extends StatefulWidget {
  const _GlassDeviceCard({
    required this.device,
    required this.onToggle,
  });

  final _RoomDeviceItem device;
  final VoidCallback onToggle;

  @override
  State<_GlassDeviceCard> createState() => _GlassDeviceCardState();
}

class _GlassDeviceCardState extends State<_GlassDeviceCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final device = widget.device;

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.98),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: device.isOn
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: device.isOn
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.08),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: device.isOn
                            ? AppColors.success
                            : Colors.white.withValues(alpha: 0.3),
                        boxShadow: device.isOn
                            ? [
                                BoxShadow(
                                  color: AppColors.success.withValues(
                                    alpha: 0.8,
                                  ),
                                  blurRadius: 8,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        device.imageAsset,
                        width: 96,
                        height: 96,
                        fit: BoxFit.contain,
                        color: device.isOn
                            ? null
                            : Colors.white.withValues(alpha: 0.4),
                        colorBlendMode:
                            device.isOn ? null : BlendMode.modulate,
                      ),
                    ),
                  ),
                  Text(
                    device.name,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: device.isOn
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    device.category,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _AppleToggle(
                        value: device.isOn,
                        onChanged: (_) => widget.onToggle(),
                      ),
                      Text(
                        device.isOn ? device.statusLabel : 'Off',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppleToggle extends StatelessWidget {
  const _AppleToggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 48,
        height: 24,
        decoration: BoxDecoration(
          color: value
              ? AppColors.success
              : Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
