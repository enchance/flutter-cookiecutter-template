import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../core/auth/providers.dart';

class ElevatedLoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;
  final Icon? icon;
  final Widget? preloader;
  final Color? preloaderColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool enabled;

  const ElevatedLoadingButton({
    required this.text,
    required this.onPressed,
    required this.loading,
    this.icon,
    this.preloader,
    this.preloaderColor,
    this.backgroundColor,
    this.foregroundColor,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading || !enabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: loading ? buildPreloader() : buildText(),
    );
  }

  Widget buildText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: 10),
        ],
        Text(text),
      ],
    );
  }

  Widget buildPreloader() {
    return SizedBox(
      width: 23,
      height: 23,
      child: preloader ??
          CircularProgressIndicator(
            color: preloaderColor ?? Colors.grey.shade400,
          ),
    );
  }
}

class GoBackButton extends StatelessWidget {
  final String? name;
  final String? text;

  const GoBackButton({this.name, this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton.icon(
        onPressed: () {
          if (name == null) return context.pop(true);
          context.goNamed(name!);
        },
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey, size: 20),
        label: Text(text ?? 'Go back', style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class GoogleLinkAccountButton extends ConsumerWidget {
  const GoogleLinkAccountButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authpending = ref.watch(authPendingProvider);

    return ElevatedLoadingButton(
      text: 'Link Google Account',
      onPressed: () => ref.read(authProvider.notifier).linkAccount(context),
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      loading: authpending == 'linkGoogle',
      icon: const Icon(Bootstrap.google),
    );
  }
}
