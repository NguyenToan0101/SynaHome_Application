import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../devices/data/device_providers.dart';
import '../../devices/domain/device.dart';
import '../domain/room.dart';

final roomsProvider = Provider<List<Room>>((ref) {
  final devices = ref.watch(devicesControllerProvider).valueOrNull ?? [];
  return [
    _room('living-room', 'Living Room', 22, devices),
    _room('bedroom', 'Bedroom', 20, devices),
    _room('kitchen', 'Kitchen', 24, devices),
    _room('garage', 'Garage', 18, devices),
    _room('bathroom', 'Bathroom', 23, devices),
    _room('garden', 'Garden', 21, devices),
  ];
});

Room _room(String id, String name, int temperature, List<Device> devices) {
  final inRoom = devices.where((device) => device.roomId == id).toList();
  return Room(
    id: id,
    name: name,
    deviceCount: inRoom.length,
    activeCount: inRoom.where((device) => device.isOn).length,
    temperature: temperature,
  );
}
