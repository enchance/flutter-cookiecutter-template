import 'package:cookiesrc/core/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

class NoticeBox extends ConsumerWidget {
  final String message;
  final Color fill;
  final Color border;
  final TextStyle style;
  final Widget? action;
  final CrossAxisAlignment crossAxisAlignment;
  final Icon? icon;

  const NoticeBox({
    required this.message,
    required this.fill,
    required this.border,
    required this.style,
    this.action,
    this.crossAxisAlignment = CrossAxisAlignment.end,
    this.icon,
    super.key,
  });

  NoticeBox.success(
    this.message, {
    this.action,
    this.crossAxisAlignment = CrossAxisAlignment.end,
    super.key,
  })  : fill = Colors.lightGreen.shade100,
        border = Colors.green.shade200,
        style = TextStyle(color: Colors.green.shade800),
        icon = Icon(Bootstrap.star_fill, size: 20, color: Colors.green.shade400);

  NoticeBox.error(
    this.message, {
    this.action,
    this.crossAxisAlignment = CrossAxisAlignment.end,
    super.key,
  })  : fill = Colors.pink.shade50,
        border = Colors.pink.shade100,
        style = TextStyle(color: Colors.pink.shade300),
        icon = Icon(Bootstrap.emoji_surprise, size: 20, color: Colors.pink.shade300);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(settings.radius),
        border: Border.all(color: border, width: 1),
        color: fill,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) icon!,
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                MarkdownBody(
                  data: message,
                  styleSheet: MarkdownStyleSheet(
                    p: style,
                    a: style.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                if (action != null) action!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
