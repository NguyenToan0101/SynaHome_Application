import '../domain/device.dart';
import '../domain/device_repository.dart';

class MockDeviceRepository implements DeviceRepository {
  final List<Device> _devices = [
    const Device(
      id: 'living-lamp',
      name: 'Living Room Lamp',
      roomId: 'living-room',
      type: DeviceType.light,
      status: DeviceStatus.online,
      isOn: true,
      brightness: 80,
      energyWatts: 9.4,
      subtitle: '80% Brightness',
      isFavorite: true,
    ),
    const Device(
      id: 'bedroom-ac',
      name: 'Bedroom AC',
      roomId: 'bedroom',
      type: DeviceType.thermostat,
      status: DeviceStatus.online,
      isOn: true,
      temperature: 20,
      energyWatts: 680,
      subtitle: 'Cooling to 20C',
      isFavorite: true,
    ),
    const Device(
      id: 'main-lock',
      name: 'Main Entrance',
      roomId: 'entry',
      type: DeviceType.lock,
      status: DeviceStatus.online,
      isOn: true,
      energyWatts: 1.2,
      subtitle: 'Secured',
      isFavorite: true,
    ),
    const Device(
      id: 'kitchen-speaker',
      name: 'Kitchen Speaker',
      roomId: 'kitchen',
      type: DeviceType.speaker,
      status: DeviceStatus.online,
      isOn: true,
      brightness: 45,
      energyWatts: 12,
      subtitle: 'Morning Jazz Playlist',
      isFavorite: true,
    ),
    const Device(
      id: 'patio-camera',
      name: 'Patio Camera',
      roomId: 'patio',
      type: DeviceType.camera,
      status: DeviceStatus.online,
      isOn: true,
      energyWatts: 6.8,
      subtitle: 'Live',
    ),
    const Device(
      id: 'office-fan',
      name: 'Office Fan',
      roomId: 'office',
      type: DeviceType.fan,
      status: DeviceStatus.offline,
      isOn: false,
      energyWatts: 0,
      subtitle: 'Offline',
    ),
  ];

  @override
  Future<List<Device>> getDevices() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return List<Device>.unmodifiable(_devices);
  }

  @override
  Future<Device> getDeviceById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return _devices.firstWhere((device) => device.id == id);
  }

  @override
  Future<Device> updateDeviceState(String id, DeviceCommand command) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final index = _devices.indexWhere((device) => device.id == id);
    final updated = _devices[index].copyWith(
      isOn: command.isOn,
      brightness: command.brightness,
      temperature: command.temperature,
    );
    _devices[index] = updated;
    return updated;
  }
}
