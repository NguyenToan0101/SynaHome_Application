import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../localization/l10n_extensions.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScaffold extends StatelessWidget {
  const ShellScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final tabs = [
      (Icons.home_outlined, Icons.home_rounded),
      (Icons.grid_view_outlined, Icons.grid_view_rounded),
      (Icons.smart_toy_outlined, Icons.smart_toy_rounded),
      (Icons.bolt_outlined, Icons.bolt_rounded),
      (Icons.person_outline_rounded, Icons.person_rounded),
    ];

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1C1C1E).withValues(alpha: 0.7)
                  : Colors.white.withValues(alpha: 0.7),
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.08),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabs.length, (index) {
                final isSelected = navigationShell.currentIndex == index;
                final tab = tabs[index];
                return Expanded(
                  child: Semantics(
                    button: true,
                    selected: isSelected,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        navigationShell.goBranch(
                          index,
                          initialLocation: index == navigationShell.currentIndex,
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedScale(
                            duration: const Duration(milliseconds: 100),
                            scale: isSelected ? 1.1 : 1.0,
                            child: Icon(
                              isSelected ? tab.$2 : tab.$1,
                              size: 24,
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : (isDark ? Colors.white54 : Colors.black54),
                            ),
                          ),
                          const SizedBox(height: 6),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 150),
                            opacity: isSelected ? 1.0 : 0.0,
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
