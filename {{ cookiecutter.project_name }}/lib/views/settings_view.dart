import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:go_router/go_router.dart';

import '../core/actions.dart';
import '../core/core.dart';
import '../components/components.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configprov = ref.read(appConfigProvider.notifier);
    final config = ref.watch(appConfigProvider);
    final settings = ref.watch(settingsProvider);

    final theme = Theme.of(context);
    final textStyle = appTextStyle(context, config.textSize);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        actions: const [
          AppbarMenuPopupMenu(),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SettingsList(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            lightTheme: generateSettingsUIStyle(context),
            darkTheme: generateSettingsUIStyle(context),
            sections: [
              SettingsSection(
                title: const Text('Apearance'),
                tiles: [
                  SettingsTile.switchTile(
                    onToggle: (bool val) => configprov.toggleDarkMode(val),
                    initialValue: config.darkMode,
                    leading: const Icon(Icons.dark_mode_outlined),
                    title: Text('Dark mode', style: textStyle),
                  ),
                  SettingsTile(
                    title: Text('Grid Size', style: textStyle),
                    leading: const Icon(BoxIcons.bx_grid_alt),
                    trailing: DropdownButton<GridSize>(
                        onChanged: (val) => configprov.setGridSize(val ?? config.gridSize),
                        value: config.gridSize,
                        dropdownColor: theme.colorScheme.surface,
                        style: Theme.of(context).textTheme.bodyMedium,
                        underline: Container(),
                        items: const [
                          DropdownMenuItem(value: GridSize.small, child: Text('Small')),
                          DropdownMenuItem(value: GridSize.medium, child: Text('Medium')),
                          DropdownMenuItem(value: GridSize.large, child: Text('Large')),
                        ]),
                    onPressed: null,
                  ),
                  SettingsTile(
                    title: Text('Text Size', style: textStyle),
                    leading: const Icon(Icons.text_fields),
                    trailing: DropdownButton<TextSize>(
                        onChanged: (val) => configprov.setTextSize(val ?? config.textSize),
                        value: config.textSize,
                        dropdownColor: theme.colorScheme.surface,
                        style: Theme.of(context).textTheme.bodyMedium,
                        underline: Container(),
                        items: const [
                          DropdownMenuItem(
                            value: TextSize.small,
                            // enabled: false,
                            child: Text('Small'),
                          ),
                          DropdownMenuItem(
                            value: TextSize.medium,
                            child: Text('Medium'),
                          ),
                          DropdownMenuItem(
                            value: TextSize.large,
                            // enabled: false,
                            child: Text('Large'),
                          ),
                          DropdownMenuItem(
                            value: TextSize.xlarge,
                            // enabled: false,
                            child: Text('XL'),
                          ),
                        ]),
                    onPressed: null,
                  ),
                  SettingsTile(
                    title: Text('Fetch count', style: textStyle),
                    leading: const Icon(Bootstrap.list_nested),
                    trailing: DropdownButton<int>(
                        value: config.fetchCount,
                        onChanged: (val) => configprov.setFetchCount(val ?? defaultFetchCount),
                        dropdownColor: theme.colorScheme.surface,
                        style: Theme.of(context).textTheme.bodyMedium,
                        underline: Container(),
                        items: const [
                          DropdownMenuItem(value: 10, child: Text('10 items')),
                          DropdownMenuItem(value: 20, child: Text('20 items')),
                          DropdownMenuItem(value: 30, child: Text('30 items')),
                        ]),
                    // onPressed: (context) {
                    //   logger.d(context);
                    // },
                  ),
                ],
              ),
              SettingsSection(
                title: const Text('Others'),
                tiles: [
                  if (settings.rateAndroidUrl.isNotEmpty)
                    SettingsTile.navigation(
                      onPressed: (context) => openUrl(context, settings.rateAndroidUrl),
                      leading: const Icon(Bootstrap.star),
                      title: Text('Rate the app', style: textStyle),
                    ),
                  if (settings.facebookUrl.isNotEmpty)
                    SettingsTile.navigation(
                      onPressed: (context) => openUrl(
                        context,
                        settings.facebookUrl,
                      ),
                      leading: const Icon(Bootstrap.facebook),
                      title: Text('Facebook', style: textStyle),
                    ),
                  if (settings.instagramUrl.isNotEmpty)
                    SettingsTile.navigation(
                      onPressed: (context) => openUrl(
                        context,
                        settings.instagramUrl,
                      ),
                      leading: const Icon(Bootstrap.instagram),
                      title: Text('Instagram', style: textStyle),
                    ),
                  SettingsTile.navigation(
                    onPressed: (_) => signOut(context, ref),
                    leading: Icon(Icons.logout, color: Colors.red.shade300),
                    title: Text('Sign-out', style: textStyle.copyWith(color: Colors.red.shade300)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          const GoBackButton(),
          SizedBox(height: settings.bottomGap),
          buildVersionInfo(ref),
          SizedBox(height: settings.bottomGap),
        ],
      )),
    );
  }

  Widget buildVersionInfo(WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    final styleSheet = MarkdownStyleSheet(
      textAlign: WrapAlignment.center,
      p: const TextStyle(color: Colors.grey),
    );

    return Column(
      children: [
        const Icon(BoxIcons.bx_bowl_hot, color: Colors.grey),
        MarkdownBody(
          styleSheet: styleSheet,
          data: 'v${packageInfo.version}',
        ),
        MarkdownBody(
          styleSheet: styleSheet,
          data: """
Jimbong Labs  
${DateTime.now().year}
""",
        ),
      ],
    );
  }
}
