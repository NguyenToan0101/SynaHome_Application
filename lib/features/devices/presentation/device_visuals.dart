import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../domain/device.dart';

/// Map thuần UI: DeviceType/id → icon, màu glow, ảnh sản phẩm.
/// Ảnh nào chưa có asset thật thì trả null (card sẽ fallback icon tile)
/// — danh sách còn thiếu ghi ở assets/ASSETS_NEEDED.md.
abstract final class DeviceVisuals {
  static IconData icon(DeviceType type) => switch (type) {
    DeviceType.light => Icons.lightbulb_rounded,
    DeviceType.thermostat => Icons.ac_unit_rounded,
    DeviceType.lock => Icons.lock_rounded,
    DeviceType.speaker => Icons.speaker_rounded,
    DeviceType.camera => Icons.videocam_rounded,
    DeviceType.fan => Icons.air_rounded,
    DeviceType.sensor => Icons.sensors_rounded,
  };

  /// Màu accent/glow theo loại thiết bị (dark-first).
  static Color accent(DeviceType type, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return switch (type) {
      DeviceType.light => AppColors.auroraWarning,
      DeviceType.thermostat =>
        isDark ? AppColors.auroraAccent : AppColors.primary,
      DeviceType.lock =>
        isDark ? AppColors.auroraMint : AppColors.auroraMintOnLight,
      DeviceType.speaker => AppColors.orbViolet,
      DeviceType.camera => isDark ? AppColors.auroraAccent : AppColors.primary,
      DeviceType.fan => AppColors.orbTeal,
      DeviceType.sensor =>
        isDark ? AppColors.auroraMint : AppColors.auroraMintOnLight,
    };
  }

  /// Ảnh sản phẩm PNG (nền trong) cho grid card trong phòng.
  static String? productImage(Device device) {
    const byId = <String, String>{
      'living-ceiling':
          'assets/images/room_devices/livingroom_devices/celling light.png',
      'living-lamp':
          'assets/images/room_devices/livingroom_devices/pendant light.png',
      'living-ac':
          'assets/images/room_devices/livingroom_devices/Air conditioner.png',
    };
    return byId[device.id] ?? _typeProductImage(device.type);
  }

  static String? _typeProductImage(DeviceType type) => switch (type) {
    DeviceType.light =>
      'assets/images/room_devices/livingroom_devices/pendant light.png',
    DeviceType.thermostat =>
      'assets/images/room_devices/livingroom_devices/Air conditioner.png',
    DeviceType.fan => 'assets/images/devices/fan.jpg',
    DeviceType.lock => 'assets/images/devices/Smart Lock.jpg',
    _ => null,
  };

  /// Ảnh lớn làm background full-bleed cho màn device detail.
  static String? detailImage(Device device) => switch (device.type) {
    DeviceType.light => 'assets/images/devices/light.jpg',
    DeviceType.thermostat => 'assets/images/devices/Air Conditioner.jpg',
    DeviceType.fan => 'assets/images/devices/fan.jpg',
    DeviceType.lock => 'assets/images/devices/Smart Lock.jpg',
    _ => null,
  };

  /// Ảnh nền phòng full-bleed (dọc) cho màn room device.
  static String? roomBackground(String roomId) => switch (roomId) {
    'living-room' => 'assets/images/rooms/vertical_room/livingroom.png',
    'bedroom' => 'assets/images/rooms/vertical_room/bedroom.jpg',
    'kitchen' => 'assets/images/rooms/vertical_room/kitchen.jpg',
    'garage' => 'assets/images/rooms/vertical_room/garage.jpg',
    'bathroom' => 'assets/images/rooms/vertical_room/bathroom.jpg',
    'garden' => 'assets/images/rooms/vertical_room/garden.jpg',
    _ => null,
  };

  /// Ảnh (ngang) cho card phòng ở màn Rooms overview.
  static String? roomCardImage(String roomId) => switch (roomId) {
    'living-room' => 'assets/images/rooms/horizontal_room/livingroom.jpg',
    'bedroom' => 'assets/images/rooms/horizontal_room/bedroom.jpg',
    'kitchen' => 'assets/images/rooms/horizontal_room/kitchen.jpg',
    'garage' => 'assets/images/rooms/horizontal_room/garage.jpg',
    'bathroom' => 'assets/images/rooms/horizontal_room/bathroom.jpg',
    'garden' => 'assets/images/rooms/horizontal_room/garden.jpg',
    _ => null,
  };
}
