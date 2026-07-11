class Room {
  const Room({
    required this.id,
    required this.name,
    required this.deviceCount,
    required this.activeCount,
    required this.temperature,
  });

  final String id;
  final String name;
  final int deviceCount;
  final int activeCount;
  final int temperature;
}
