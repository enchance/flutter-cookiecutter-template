import 'package:flutter/material.dart';

enum FontSizes { small, medium, large }

// double getFontSize(BuildContext context, FontSizes label) {
//   final size = label.name;
//   return switch (size) {
//     'sm' => Theme.of(context).textTheme.bodySmall!.fontSize!,
//     'lg' => Theme.of(context).textTheme.bodyMedium!.fontSize!,
//     _ => Theme.of(context).textTheme.bodyLarge!.fontSize!,
//   };
// }

enum ViewName {
  none,
  authgate,
  landing,
  home,
  scan,
  session,
  accounts,
  branches,
  organizations,
  settings
}
