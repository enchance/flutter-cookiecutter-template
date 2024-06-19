import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/core.dart';

class TextWithIcon extends ConsumerWidget {
  final bool enabled;
  final String text;
  final IconData iconData;
  final double iconSize;
  final Color? color;

  const TextWithIcon(
      {required this.text,
      required this.iconData,
      this.enabled = true,
      this.iconSize = 20,
      this.color,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          iconData,
          size: iconSize,
          color: enabled
              ? color ?? theme.colorScheme.onSurface
              : theme.colorScheme.onSurface.withOpacity(opacity2),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              color: enabled
                  ? color ?? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withOpacity(opacity2),
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            ),
          ),
        ),
        // Text(label, style: getPopupItemTextStyle(context, actualfontsize, color)),
      ],
    );
  }
}
