import 'package:cookiesrc/components/buttons.dart';
import 'package:cookiesrc/core/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../core.dart';
import '../auth_components.dart';

class AuthSelectionView extends ConsumerStatefulWidget {
  const AuthSelectionView({super.key});

  @override
  ConsumerState createState() => _AuthSelectionViewState();
}

class _AuthSelectionViewState extends ConsumerState<AuthSelectionView> {
  bool onFailed = false;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final authprov = ref.watch(authProvider);
    final xprov = ref.watch(xSignInProvider);

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
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: settings.padx),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const MastheadPlaceholderImage(),
                    if (onFailed) ...[
                      const SizedBox(height: 20),
                      NoticeBox.error(errorMessages['FAILED_GOOGLE_SIGNIN']!),
                    ],
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxWidth: settings.maxWidth),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade600,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => ref.read(authProvider.notifier).signInWithGoogle(),
                        child: authprov.maybeWhen(
                            loading: () => const ButtonLoading(color: Colors.white),
                            orElse: () => const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Bootstrap.google),
                                    SizedBox(width: 10),
                                    Text('Google Sign-in'),
                                  ],
                                )),
                      ),
                    ),
                    // const SizedBox(height: 10),
                    // Container(
                    //   width: double.infinity,
                    //   constraints: BoxConstraints(maxWidth: settings.maxWidth),
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.grey.shade800,
                    //       foregroundColor: Colors.white,
                    //     ),
                    //     onPressed: () => ref.read(xSignInProvider.notifier).signInWithX(),
                    //     child: xprov.maybeWhen(
                    //         loading: () => const ButtonLoading(color: Colors.white),
                    //         orElse: () => const Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Icon(Bootstrap.twitter_x),
                    //             SizedBox(width: 10),
                    //             Text('X Sign-in'),
                    //           ],
                    //         )
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    const Text('or'),
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
                        label: const Text('Email Sign-in'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const RegisterHereText(),
                    // ...List.generate(20, (index) => Text(index.toString())),
                    SizedBox(height: settings.bottomGap),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
