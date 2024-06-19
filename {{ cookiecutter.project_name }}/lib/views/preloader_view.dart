import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../core/constants.dart';

class PreloaderView extends StatelessWidget {
  const PreloaderView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Replace this with the app logo
            LoadingAnimationWidget.discreteCircle(
              color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
              secondRingColor: theme.colorScheme.primary,
              thirdRingColor: Colors.orange,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
