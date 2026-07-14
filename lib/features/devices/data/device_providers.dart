import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/device.dart';
import '../domain/device_repository.dart';
import 'mock_device_repository.dart';

final deviceRepositoryProvider = Provider<DeviceRepository>((ref) {
  return MockDeviceRepository();
});

final devicesControllerProvider =
    StateNotifierProvider<DevicesController, AsyncValue<List<Device>>>((ref) {
      return DevicesController(ref.watch(deviceRepositoryProvider))..load();
    });

class DevicesController extends StateNotifier<AsyncValue<List<Device>>> {
  DevicesController(this._repository) : super(const AsyncValue.loading());

  final DeviceRepository _repository;

  Future<void> load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_repository.getDevices);
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(_repository.getDevices);
  }

  Future<void> updateDevice(String id, DeviceCommand command) async {
    final previous = state.valueOrNull ?? const <Device>[];
    final updated = await _repository.updateDeviceState(id, command);
    state = AsyncValue.data([
      for (final device in previous) device.id == id ? updated : device,
    ]);
  }
}
