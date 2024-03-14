import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../core/core.dart';
import '../components/components.dart';
import '../core/auth/auth_components.dart';

class IndexView extends ConsumerStatefulWidget {
  const IndexView({super.key});

  @override
  ConsumerState createState() => _IndexViewState();
}

class _IndexViewState extends ConsumerState<IndexView> {
  bool onFailed = false;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final authprov = ref.watch(authProvider);
    final anonyprov = ref.watch(anonymousSignInProvider);

    ref.listen(anonymousSignInProvider, (_, next) {
      if (next.isLoading) return;
      if (next.hasError) setState(() => onFailed = true);
    });

    ref.listen(authProvider, (_, next) {
      if (next.isLoading) return;
      if (next.hasError) setState(() => onFailed = true);
    });

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
                    if (onFailed) ...[
                      const SizedBox(height: 20),
                      NoticeBox.error(errorMessages['FAILED_SIGNIN']!),
                    ],
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxWidth: settings.maxWidth),
                      child: OutlinedButton(
                        // onPressed: null,
                        // onPressed: () {},
                        onPressed: anonyprov.maybeWhen(
                          loading: () => null,
                          orElse: () => ref.read(anonymousSignInProvider.notifier).signIn,
                        ),
                        child: anonyprov.maybeWhen(
                            loading: () => const ButtonLoading(),
                            orElse: () => const Text('Get started')),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('or'),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxWidth: settings.maxWidth),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade600,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: authprov.maybeWhen(
                          loading: () => null,
                          orElse: () => ref.read(authProvider.notifier).signInWithGoogle,
                        ),
                        child: authprov.maybeWhen(
                            loading: () => const ButtonLoading(),
                            orElse: () => const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Bootstrap.google),
                                SizedBox(width: 10),
                                Text('Sign-in with Google'),
                              ],
                            )),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxWidth: settings.maxWidth),
                      child: ElevatedButton.icon(
                        onPressed: () => context.goNamed('signin'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.email_outlined),
                        label: const Text('Sign-in with Email'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const RegisterHereText(),
                    // const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     // const Text('No account yet?', style: TextStyle(color: Colors.grey)),
                    //     TextButton.icon(
                    //       onPressed: () => context.goNamed('auth'),
                    //       icon: const Icon(Bootstrap.person_circle, color: Colors.grey, size: 20),
                    //       label: const Text('Sign-in with account',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.grey,
                    //           )),
                    //     ),
                    //   ],
                    // ),
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
}
