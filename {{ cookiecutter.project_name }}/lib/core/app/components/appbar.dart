import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../components/components.dart';
import '../../core.dart';

class AppbarMenuPopupMenu extends ConsumerWidget {
  const AppbarMenuPopupMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountProvider);
    final prefs = ref.watch(prefsProvider);
    final String fullpath = GoRouterState.of(context).matchedLocation;
    final enableSettings = fullpath != '/settings';
    final enableAccount = fullpath != '/account';

    return PopupMenuButton(
      icon: account.avatar.isNotEmpty
          ? CircleAvatar(
              radius: 24,
              backgroundImage: CachedNetworkImageProvider(account.avatar),
            )
          : null,
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () => context.goNamed('account'),
          padding: const EdgeInsets.only(left: 16),
          enabled: enableAccount,
          child: TextWithIcon(
            iconData: Bootstrap.person_circle,
            text: 'Account',
            enabled: enableAccount,
          ),
        ),
        PopupMenuItem(
          onTap: () => context.pushNamed('settings'),
          padding: const EdgeInsets.only(left: 16),
          enabled: enableSettings,
          child: TextWithIcon(
            iconData: Icons.settings,
            text: 'Settings',
            enabled: enableSettings,
          ),
        ),
        PopupMenuItem(
          onTap: () async => signOut(context, ref),
          padding: const EdgeInsets.only(left: 16),
          child: const TextWithIcon(
            iconData: Icons.logout,
            text: 'Sign-out',
          ),
        ),
        if (kDebugMode)
          PopupMenuItem(
            onTap: () async {
              prefs.clear();
              signOut(context, ref);
            },
            padding: const EdgeInsets.only(left: 16),
            child: const TextWithIcon(
              iconData: Bootstrap.x_circle,
              text: 'Clear prefs',
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}
