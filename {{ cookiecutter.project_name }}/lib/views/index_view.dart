import 'package:cookiesrc/core/themes/base_theme.dart';
import 'package:cookiesrc/core/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../core/core.dart';

class IndexView extends ConsumerStatefulWidget {
  const IndexView({super.key});

  @override
  ConsumerState createState() => _IndexViewState();
}

class _IndexViewState extends ConsumerState<IndexView> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final authprov = ref.watch(authProvider);

    // ref.listen(signInAnonProvider, (previous, next) {
    //   if(!next.isLoading && next.hasValue) context.goNamed('/');
    // });

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: settings.padx),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const MastheadPlaceholderImage(),
                    const SizedBox(height: 20),
                    Text(
                      'This is something that does something',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxWidth: settings.maxWidth),
                      child: ElevatedButton(
                        onPressed: authprov.maybeWhen(
                          loading: () => null,
                          orElse: () => ref.read(authProvider.notifier).signInAnonymously,
                        ),
                        child: authprov.maybeWhen(
                            loading: () => SpinKitThreeBounce(
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                                  size: 20,
                                ),
                            orElse: () => const Text('Get started')),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Text('No account yet?', style: TextStyle(color: Colors.grey)),
                        TextButton.icon(
                          onPressed: () => context.goNamed('auth'),
                          icon: const Icon(Bootstrap.person_circle, color: Colors.grey, size: 20),
                          label: const Text('Sign-in with account',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              )),
                        ),
                      ],
                    ),
                    // ...List.generate(50, (index) => Text(index.toString())),
                    SizedBox(height: settings.bottomGap),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void signInAnon() async {
    try {
      ref.read(authProvider.notifier).signInAnonymously();
    } on FirebaseAuthException catch (err) {
      if (err.code == 'operation-not-allowed') {
        return logger.e("Anonymous auth hasn't been enabled for this project.");
      }
      return logger.e('Unknown error.');
    } catch (err) {
      logger.e(err);
      rethrow;
    }
  }
}
