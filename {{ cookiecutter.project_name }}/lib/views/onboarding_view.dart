import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../core/core.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    final signinprov = ref.watch(authPendingProvider);

    final pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.titleSmall!,
      bodyTextStyle: Theme.of(context).textTheme.bodyMedium!,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      animationDuration: 300,
      onDone: () => startApp(context),
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      done: signinprov == 'anonymous'
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            )
          : const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //     child: const Text(
      //       'Get started',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () => startApp(context),
      //   ),
      // ),
      dotsDecorator: DotsDecorator(
        color: Colors.grey.shade400,
        activeColor: Theme.of(context).colorScheme.primary,
        activeSize: const Size(25.0, 9.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      pages: [
        PageViewModel(
          title: 'Scanning app that works',
          decoration: pageDecoration,
          image: Icon(Icons.icecream, size: 100, color: Colors.pink.shade300),
          body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
        ),
        PageViewModel(
          title: 'A more efficient store',
          image: const Icon(Bootstrap.robot, size: 100, color: Colors.green),
          decoration: pageDecoration,
          body:
              'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        ),
        PageViewModel(
          title: 'Easy data access',
          image: Icon(Icons.phonelink, size: 100, color: Colors.red.shade700),
          decoration: pageDecoration,
          bodyWidget: const MarkdownBody(
            data: '''
We've made it easier to access your data on **multiple devices** by linking to your 
Google account.
''',
          ),
        ),
      ],
    );
  }

  void startApp(BuildContext context) async {
    final settings = ref.watch(settingsProvider);
    final prefs = ref.watch(prefsProvider);

    final List<Future<void>> futures = [
      prefs.setBool('showOnboarding', false),
      prefs.setBool('showAuthWall', settings.authWallAsDefault),
      if (!settings.authWallAsDefault) ref.read(authProvider.notifier).anonymousSignIn(),
    ];
    await Future.wait(futures);
    if (settings.authWallAsDefault && context.mounted) context.goNamed('authwall');
  }
}
