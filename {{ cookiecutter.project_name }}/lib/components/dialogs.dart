import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../core/core.dart';

// void appDialog(BuildContext context,
//     {Widget? titleAndroid,
//       Widget? titleIos,
//       required Widget messageAndroid,
//       bool barrierDisimssible = true,
//       Widget? messageIos,
//       bool showCancel = false,
//       VoidCallback? action,
//       String? actionText}) {
//   if (defaultTargetPlatform == TargetPlatform.iOS ||
//       defaultTargetPlatform == TargetPlatform.macOS) {
//     // TODO: Update from android side
//     showCupertinoDialog(
//       barrierDismissible: barrierDisimssible,
//       context: context,
//       builder: (context) {
//         return CupertinoAlertDialog(
//           title: titleIos ?? titleAndroid,
//           content: messageIos ?? messageAndroid,
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (showCancel)
//                   CupertinoDialogAction(
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text('Cancel'),
//                   ),
//                 CupertinoDialogAction(
//                   onPressed: action ?? () => Navigator.pop(context),
//                   child: Text(actionText ?? 'Close'),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   } else {
//     showDialog(
//       barrierDismissible: barrierDisimssible,
//       barrierColor: Colors.black38,
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Theme.of(context).colorScheme.surface,
//           title: titleAndroid,
//           content: messageAndroid,
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 showCancel
//                     ? TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Cancel'),
//                 )
//                     : const SizedBox.shrink(),
//                 TextButton(
//                   onPressed: action ?? () => Navigator.pop(context),
//                   child: Text(actionText ?? 'Ok'),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

Future<BuildContext?> showAppDialog(
  BuildContext context, {
  required String title,
  required String message,
  required (String, String) actionText,
  ActionStatus? state,
  bool barrierDisimssible = true,
  Future<bool> Function()? action,
  bool showCancel = false,
  IconData? iconData,
  String retryText = 'Try again',
  Widget? footer,
}) async {
  var (text, loadingText) = actionText;
  return await showDialog(
    barrierDismissible: barrierDisimssible,
    barrierColor: Colors.black38,
    context: context,
    builder: (context) {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      final surface = colorScheme.surface;
      final onSurface = colorScheme.onSurface;
      final bodyMediumTheme = theme.textTheme.bodyMedium;

      return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: surface,
          icon: iconData != null ? Icon(iconData, size: 34) : null,
          title: Text(
            title,
            style: bodyMediumTheme!.copyWith(fontWeight: FontWeight.bold, color: onSurface),
          ),
          content: Column(
            children: [
              MarkdownBody(
                data: message,
                styleSheet: MarkdownStyleSheet(p: bodyMediumTheme.copyWith(color: onSurface)),
                selectable: true,
              ),
              if (footer != null) ...[const SizedBox(height: 20), footer],
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showCancel
                    ? TextButton(
                        onPressed:
                            state == ActionStatus.loading ? null : () => Navigator.pop(context),
                        child: Text('Cancel', style: TextStyle(color: theme.colorScheme.secondary)),
                      )
                    : const SizedBox.shrink(),
                TextButton(
                  onPressed: state == ActionStatus.loading
                      ? null
                      : state != null
                          ? () async {
                              setState(() => state = ActionStatus.loading);
                              if (action == null) return Navigator.pop(context);

                              final bool success = await action();
                              if (success) {
                                if (context.mounted) return Navigator.pop(context, context);
                              } else {
                                setState(() => state = ActionStatus.fail);
                              }
                            }
                          : () => Navigator.pop(context),
                  child: Text(
                    state == ActionStatus.loading
                        ? loadingText
                        : (state == ActionStatus.fail ? retryText : text),
                    style: TextStyle(color: theme.colorScheme.secondary),
                  ),
                ),
              ],
            ),
          ],
        );
      });
    },
  );
}

Future<BuildContext?> showMessageDialog(
  BuildContext context, {
  required String message,
  String title = 'Message',
  String? actionText,
  IconData? iconData,
  Widget? footer,
}) {
  return showAppDialog(
    context,
    title: title,
    message: message,
    actionText: (actionText ?? 'Ok', ''),
    iconData: iconData,
    footer: footer,
  );
}

Future<BuildContext?> showErrorDialog(
  BuildContext context, {
  required String message,
  String title = 'Error',
  String? actionText,
  IconData? iconData,
  Widget? footer,
}) {
  return showAppDialog(
    context,
    title: title,
    message: message,
    actionText: (actionText ?? 'Ok', ''),
    iconData: iconData ?? Icons.warning,
    footer: footer,
  );
}

// void errorDialog(BuildContext context, dynamic err,
//     {String? title, VoidCallback? action, String? actionText, bool barrierDisimssible = true}) {
//   String message_;
//   String title_;
//
//   final onSurface = Theme.of(context).colorScheme.onSurface;
//   const iconOpacity = 0.5;
//
//   message_ = err is String ? err : err?.message ?? err.toString();
//   if (message_ == 'Exception') {
//     message_ = 'Report this error so we can get it fixed.';
//   }
//
//   try {
//     title_ = title ?? err.title;
//   } on NoSuchMethodError {
//     title_ = 'ERROR';
//   }
//
//   appDialog(context,
//       action: action,
//       actionText: actionText,
//       barrierDisimssible: barrierDisimssible,
//       titleAndroid: Row(children: [
//         Icon(BoxIcons.bx_message_error, color: onSurface.withOpacity(iconOpacity)),
//         const SizedBox(width: 10),
//         Text(title_,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
//               color: onSurface,
//             )),
//       ]),
//       messageAndroid: MarkdownBody(
//         data: message_,
//         styleSheet: MarkdownStyleSheet(p: TextStyle(color: onSurface)),
//       ));
// }
