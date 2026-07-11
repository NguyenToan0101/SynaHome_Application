import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/l10n_extensions.dart';
import '../../../app/theme/app_spacing.dart';
import '../../authentication/presentation/auth_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authControllerProvider).session;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profile)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screen),
        children: [
          CircleAvatar(
            radius: 42,
            child: Text((session?.name ?? 'A').characters.first),
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: Text(
              session?.email ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: Text(l10n.notifications),
            onTap: () => context.go('/profile/notifications'),
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: Text(l10n.settings),
            onTap: () => context.go('/profile/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: Text(l10n.signOut),
            onTap: () => ref.read(authControllerProvider.notifier).logout(),
          ),
          ListTile(
            leading: Icon(
              Icons.delete_outline_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(l10n.deleteAccount),
            onTap: () =>
                ref.read(authControllerProvider.notifier).deleteAccount(),
          ),
        ],
      ),
    );
  }
}
