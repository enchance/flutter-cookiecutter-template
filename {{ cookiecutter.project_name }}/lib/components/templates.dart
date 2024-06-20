import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../core/core.dart';

class ScaffoldWithNavBar extends ConsumerWidget {
  final Role role;

  // final FeatureAccess feature;
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    required this.navigationShell,
    required this.role,
    // required this.feature,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final account = ref.watch(userAccountProvider);
    // final feature = ref.watch(featureProvider);

    // if (feature.hasBanner) {
    //   return Banner(
    //     color: Colors.grey,
    //     message: 'PopolPH',
    //     location: BannerLocation.topEnd,
    //     child: buildScaffold(context, ref),
    //   );
    // }
    return buildScaffold(context, ref);
  }

  Widget buildScaffold(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onPrimary.withOpacity(0.8);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) => _onTap(context, index),
        selectedIndex: navigationShell.currentIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home, color: color),
            label: 'Home',
          ),
          // if (feature.isDist || (feature.isPopol && role == Role.admin))
          NavigationDestination(
            icon: Icon(Bootstrap.balloon_fill, color: color),
            label: 'API',
          ),
          NavigationDestination(
            icon: Icon(Icons.search, color: color),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Bootstrap.briefcase_fill, color: color),
            label: 'Autumn',
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
