abstract interface class NotificationService {
  Future<void> initialize();

  Future<void> requestPermissionWithContext();

  Future<void> registerDeviceToken(String token);

  Future<void> handleNotificationTap(Uri deepLink);
}

class DeferredNotificationService implements NotificationService {
  @override
  Future<void> initialize() async {}

  @override
  Future<void> requestPermissionWithContext() async {}

  @override
  Future<void> registerDeviceToken(String token) async {}

  @override
  Future<void> handleNotificationTap(Uri deepLink) async {}
}
