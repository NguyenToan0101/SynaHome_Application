enum DeviceType { light, thermostat, lock, speaker, camera, fan, sensor }

enum DeviceStatus { online, offline }

class Device {
  const Device({
    required this.id,
    required this.name,
    required this.roomId,
    required this.type,
    required this.status,
    required this.isOn,
    this.brightness,
    this.temperature,
    this.energyWatts,
    this.subtitle,
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final String roomId;
  final DeviceType type;
  final DeviceStatus status;
  final bool isOn;
  final int? brightness;
  final int? temperature;
  final double? energyWatts;
  final String? subtitle;
  final bool isFavorite;

  Device copyWith({
    DeviceStatus? status,
    bool? isOn,
    int? brightness,
    int? temperature,
    double? energyWatts,
    String? subtitle,
    bool? isFavorite,
  }) {
    return Device(
      id: id,
      name: name,
      roomId: roomId,
      type: type,
      status: status ?? this.status,
      isOn: isOn ?? this.isOn,
      brightness: brightness ?? this.brightness,
      temperature: temperature ?? this.temperature,
      energyWatts: energyWatts ?? this.energyWatts,
      subtitle: subtitle ?? this.subtitle,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class DeviceCommand {
  const DeviceCommand({
    this.isOn,
    this.brightness,
    this.temperature,
  });

  final bool? isOn;
  final int? brightness;
  final int? temperature;
}
