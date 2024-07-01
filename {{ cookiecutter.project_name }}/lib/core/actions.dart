import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core.dart';
import '../components/components.dart';

/// Scroll to the top of the view. With [unfocus] if there is a keyboard open it is immediately
/// closed which is probably what you want.
Future<void> scrollToTop(ScrollController scrollcon, {bool unfocus = true}) async {
  if (unfocus) FocusManager.instance.primaryFocus?.unfocus();
  if (scrollcon.hasClients) scrollcon.jumpTo(0);
}

/// Sign out the user. [text] is optional text shown in the sign-in view if needed.
Future<void> signOut(BuildContext context, dynamic ref, {String? text}) async {
  final prefs = ref.watch(prefsProvider);
  // Sign-out
  await prefs.setBool('showAuthWall', true);
  await ref.read(authProvider.notifier).signOut();

  // -------------------------------------------
  // Clean up
  // -------------------------------------------
  if (context.mounted) {
    ref.read(accountProvider.notifier).update((_) => Account.empty());
    ref.read(authPendingProvider.notifier).update((_) => '');
    ref.read(signOutTextProvider.notifier).update((_) => text);
    ref.read(appConfigProvider.notifier).clear();
  }
}

/// Launch a [url].
Future<bool> openUrl(BuildContext context, String url) async {
  final uri = Uri.parse(url);

  try {
    if (await canLaunchUrl(uri)) return await launchUrl(uri);
    throw Exception('CANNOT_LAUNCH');
  } catch (err, _) {
    if (context.mounted) {
      showErrorDialog(
        context,
        title: 'Launch failed',
        message: 'Unable to launch url. Try again in a few seconds.',
      );
    }
    return false;
  }
}

/// Get the text style using the appropriate TextSize.
TextStyle appTextStyle(BuildContext context, [TextSize textSize = TextSize.medium]) {
  final theme = Theme.of(context);

  if (textSize == TextSize.small) return theme.textTheme.bodySmall!;
  if (textSize == TextSize.medium) return theme.textTheme.bodyMedium!;
  if (textSize == TextSize.large) return theme.textTheme.bodyLarge!;
  return theme.textTheme.bodyMedium!.copyWith(fontSize: 26);
}

/// Remove keys which should never be modified manually. The DB is in charge of these.
Map<String, dynamic> stripImmutableFields(Map<String, dynamic> datamap) {
  final toExclude = ['id', 'updated_at', 'created_at'];
  datamap.removeWhere((k, v) => toExclude.contains(k));
  return datamap;
}