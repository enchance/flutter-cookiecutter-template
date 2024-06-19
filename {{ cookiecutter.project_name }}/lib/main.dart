import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'shared.dart';
import 'core/core.dart';

main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await sharedMain(
    flavor: Flavor.prod,
    title: '{{ cookiecutter.project_name | capitalize }}',
    appName: '{{ cookiecutter.project_name | lower }}',
  );
}

