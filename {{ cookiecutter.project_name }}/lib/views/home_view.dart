import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../core/core.dart';
import '../components/components.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final account = ref.watch(accountProvider);
    // logger.d(account);

    bool showLinkButton = false;
    if (!account.authTypes.contains(AuthType.google)) showLinkButton = true;

    return Scaffold(
      appBar: AppBar(
        title: Text(kDebugMode ? account.uid : settings.appName),
        actions: const [
          AppbarMenu(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: settings.padx),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('View'),
              if (account.email.isNotEmpty) buildAccountData(),
              const SizedBox(height: 10),
              if (showLinkButton) const GoogleLinkAccountButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAccountData() {
    final config = ref.watch(appConfigProvider);
    final account = ref.watch(accountProvider);

    return Column(
      children: [
        if (account.avatar.isNotEmpty) ...[
          CircleAvatar(
            radius: 50,
            backgroundImage: CachedNetworkImageProvider(account.avatar),
          ),
          const SizedBox(height: 10),
        ],
        Text(account.email, style: appTextStyle(context, config.textSize)),
      ],
    );
  }
}
