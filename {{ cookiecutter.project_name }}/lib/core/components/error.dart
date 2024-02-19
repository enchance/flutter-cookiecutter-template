import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:icons_plus/icons_plus.dart';

import '../core.dart';

void appDialog(BuildContext context,
    {Widget? titleAndroid,
    Widget? titleIos,
    required Widget messageAndroid,
    bool barrierDisimssible = true,
    Widget? messageIos,
    VoidCallback? action,
    String? actionText}) {
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    showCupertinoDialog(
      barrierDismissible: barrierDisimssible,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: titleIos ?? titleAndroid,
          content: messageIos ?? messageAndroid,
          actions: [
            CupertinoDialogAction(
              child: Text(actionText ?? 'OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      barrierDismissible: barrierDisimssible,
      barrierColor: Colors.black38,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: titleAndroid,
          content: messageAndroid,
          actions: [
            TextButton(
              onPressed: action ?? () => Navigator.pop(context),
              child: Text(actionText ?? 'OK'),
            ),
          ],
        );
      },
    );
  }
}

void errorDialog(BuildContext context, dynamic err,
    {String? title, VoidCallback? action, String? actionText, bool barrierDisimssible = true}) {
  String message_;
  String title_;

  final onSurface = Theme.of(context).colorScheme.onSurface;
  const iconOpacity = 0.5;

  // TODO: Add reporting button

  message_ = err is String ? err : err?.message ?? err.toString();
  if (message_ == 'Exception') {
    message_ = 'Report this error so we can get it fixed.';
  }

  try {
    title_ = title ?? err.title;
  } on NoSuchMethodError {
    title_ = 'ERROR';
  }

  appDialog(context,
      action: action,
      actionText: actionText,
      barrierDisimssible: barrierDisimssible,
      titleAndroid: Row(children: [
        Icon(BoxIcons.bx_message_error, color: onSurface.withOpacity(iconOpacity)),
        const SizedBox(width: 10),
        Text(title_,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
              color: onSurface,
            )),
      ]),
      messageAndroid: MarkdownBody(
        data: message_,
        styleSheet: MarkdownStyleSheet(p: TextStyle(color: onSurface)),
      ));
}

void newAccountDialog(BuildContext context, String email, String? password) {
  final onSurface = Theme.of(context).colorScheme.onSurface;
  final headerStyle = Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.bold,
        color: onSurface,
      );

  appDialog(context,
      barrierDisimssible: false,
      titleAndroid: null,
      messageAndroid: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('EMAIL', style: headerStyle),
          Text(email, style: TextStyle(color: onSurface)),
          const SizedBox(height: 10),
          if (password != null) ...[
            Text('PASSWORD', style: headerStyle),
            FittedBox(
              child: Text(password,
                  style: TextStyle(
                    color: onSurface,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
          const SizedBox(height: 10),
          const Text(
              "This password will only be shown once. If you forget it you'll need to have "
              "it reset.",
              style: TextStyle(color: Colors.grey)),
        ],
      ));
}

void messageDialog(BuildContext context,
    {required String title, required String message, VoidCallback? action, String? actionText,
      IconData? iconData}) {
  final onSurface = Theme.of(context).colorScheme.onSurface;
  const iconOpacity = 0.5;

  appDialog(context,
      action: action,
      actionText: actionText,
      // barrierDisimssible: barrierDisimssible,
      titleAndroid: Row(children: [
        Icon(iconData ?? BoxIcons.bx_message, color: onSurface.withOpacity(iconOpacity)),
        const SizedBox(width: 10),
        Text(title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
              color: onSurface,
            )),
      ]),
      messageAndroid: MarkdownBody(
        data: message,
        styleSheet: MarkdownStyleSheet(p: TextStyle(color: onSurface)),
      ));
}
