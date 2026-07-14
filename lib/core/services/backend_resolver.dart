import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/network_client.dart';

enum ConnectionMode { edge, cloud, offline }

final backendResolverProvider = Provider<BackendResolver>((ref) {
  return BackendResolver(
    edgeClient: ref.watch(edgeApiClientProvider),
    cloudClient: ref.watch(cloudApiClientProvider),
  );
});

final connectionModeControllerProvider =
    StateNotifierProvider<ConnectionModeController, ConnectionMode>((ref) {
      return ConnectionModeController(ref.watch(backendResolverProvider));
    });

class BackendResolver {
  BackendResolver({
    required NetworkClient edgeClient,
    required NetworkClient cloudClient,
  }) : _edgeClient = edgeClient,
       _cloudClient = cloudClient;

  final NetworkClient _edgeClient;
  final NetworkClient _cloudClient;

  Future<ConnectionMode> resolve() async {
    final edgeHealthy = await _isHealthy(_edgeClient, seconds: 2);
    if (edgeHealthy) {
      return ConnectionMode.edge;
    }
    final cloudHealthy = await _isHealthy(_cloudClient, seconds: 5);
    return cloudHealthy ? ConnectionMode.cloud : ConnectionMode.offline;
  }

  Future<bool> _isHealthy(NetworkClient client, {required int seconds}) async {
    try {
      await client.dio.get<dynamic>(
        '/health',
        options: Options(sendTimeout: Duration(seconds: seconds)),
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}

class ConnectionModeController extends StateNotifier<ConnectionMode> {
  ConnectionModeController(this._resolver) : super(ConnectionMode.cloud) {
    refresh();
  }

  final BackendResolver _resolver;

  Future<void> refresh() async {
    state = await _resolver.resolve();
  }
}
