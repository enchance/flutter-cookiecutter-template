import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AuthGateView extends ConsumerWidget {
  final Widget landingView;
  final Widget? onboardingView;

  const AuthGateView({required this. landingView, this.onboardingView, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}