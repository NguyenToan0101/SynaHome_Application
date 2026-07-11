import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/l10n_extensions.dart';
import '../../../app/router/app_router.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/storage/app_preferences.dart';
import '../../../core/widgets/app_button.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Icon(Icons.hub_rounded, size: 72),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.onboardingTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.onboardingSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              AppButton(
                label: l10n.continueAction,
                onPressed: () async {
                  await ref
                      .read(appPreferencesProvider)
                      .setOnboardingCompleted(true);
                  ref.invalidate(appPreferencesProvider);
                  ref.invalidate(routerProvider);
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
