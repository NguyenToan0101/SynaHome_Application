import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../data/room_providers.dart';

class RoomsScreen extends ConsumerWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(roomsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rooms')),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.screen),
          itemCount: rooms.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 260,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
          ),
          itemBuilder: (context, index) {
            final room = rooms[index];
            return AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.meeting_room_rounded, size: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text('${room.activeCount}/${room.deviceCount} active'),
                      Text('${room.temperature}C'),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
