import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screen),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.onSurface,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Icon(Icons.videocam_rounded, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text('Patio Camera - Live stream placeholder'),
        ],
      ),
    );
  }
}
