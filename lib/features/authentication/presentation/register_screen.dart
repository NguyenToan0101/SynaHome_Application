import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/l10n_extensions.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import 'auth_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController(text: 'Alex');
  final _emailController = TextEditingController(text: 'alex@syna.local');
  final _passwordController = TextEditingController(text: '123456');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.signIn,
          onPressed: () => context.go('/login'),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(l10n.register),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screen),
          children: [
            AppTextField(
              label: 'Tên',
              controller: _nameController,
              prefixIcon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: l10n.email,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.mail_outline_rounded,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: l10n.password,
              controller: _passwordController,
              obscureText: true,
              prefixIcon: Icons.lock_outline_rounded,
            ),
            if (auth.errorMessage != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                auth.errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: l10n.register,
              icon: Icons.person_add_alt_1_rounded,
              isLoading: auth.isSubmitting,
              onPressed: () {
                ref.read(authControllerProvider.notifier).register(
                      _nameController.text.trim(),
                      _emailController.text.trim(),
                      _passwordController.text,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
