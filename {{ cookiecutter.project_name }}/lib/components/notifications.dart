import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../core/core.dart';


class BaseNoticeBox extends ConsumerWidget {
  final String message;
  final (Color, Color, Color) colors;
  const BaseNoticeBox({required this.message, required this.colors, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final config = ref.watch(appConfigProvider);
    final (bgColor, borderColor, textColor) = colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(settings.radius),
        border: Border.all(color: borderColor),
        color: bgColor,
      ),
      child: MarkdownBody(
        data: message,
        styleSheet: MarkdownStyleSheet(
          p: appTextStyle(context, config.textSize).copyWith(color: textColor),
          a: appTextStyle(context, config.textSize).copyWith(color: textColor),
        ),
      ),
    );
  }
}

class SuccessNoticeBox extends ConsumerWidget {
  final String message;
  const SuccessNoticeBox({required this.message, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return BaseNoticeBox(message: message, colors: settings.successBoxColors);
  }
}

class ErrorNoticeBox extends ConsumerWidget {
  final String message;
  const ErrorNoticeBox({required this.message, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return BaseNoticeBox(message: message, colors: settings.errorBoxColors);
  }
}

class InfoNoticeBox extends ConsumerWidget {
  final String message;
  const InfoNoticeBox({required this.message, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return BaseNoticeBox(message: message, colors: settings.infoBoxColors);
  }
}

class GreyNoticeBox extends ConsumerWidget {
  final String message;
  const GreyNoticeBox({required this.message, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return BaseNoticeBox(message: message, colors: settings.greyBoxColors);
  }
}