import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syna/app/app.dart';
import 'package:syna/app/config/app_environment.dart';
import 'package:syna/app/config/providers.dart';

void main() {
  testWidgets('renders login screen after onboarding', (tester) async {
    SharedPreferences.setMockInitialValues({'onboarding_completed': true});
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appEnvironmentProvider.overrideWithValue(AppEnvironment.development),
          sharedPreferencesProvider.overrideWithValue(preferences),
        ],
        child: const SynaApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Chào mừng trở lại'), findsOneWidget);
  });
}
