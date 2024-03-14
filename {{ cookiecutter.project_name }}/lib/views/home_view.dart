import 'package:cookiesrc/components/buttons.dart';
import 'package:cookiesrc/core/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../core/core.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final account = ref.watch(userAccountProvider);
    final authprov = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      if (!next.isLoading) {
        // if (next.hasValue) logger.d(next.valueOrNull);
        if (next.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Unable to link your account'),
          ));
        }
      }
    });
    // logger.d(account);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => ref.read(authProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!user.isAnonymous) ...[
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(color: Colors.grey.shade400, blurRadius: 10),
                ]),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 52,
                    child: account?.avatar.isNotEmpty ?? false
                        ? CircleAvatar(
                            // backgroundColor: Colors.grey,
                            radius: 50,
                            backgroundImage: CachedNetworkImageProvider(account!.avatar),
                          )
                        : const Icon(Bootstrap.person_circle, size: 100, color: Colors.grey)),
              ),
              const SizedBox(height: 10),
              if (account != null) ...[
                Text(account.display),
                Text(account.email),
              ],
            ],
            if (user.isAnonymous || !account!.protocols.contains(AuthType.google)) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authprov.maybeWhen(
                    loading: () => null,
                    orElse: () => () => ref.read(authProvider.notifier).linkGoogleAccount(user),
                  ),
                  child: authprov.maybeWhen(
                    loading: () => const ButtonLoading(),
                    orElse: () => const Text('Activate Google Sign-in'),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
