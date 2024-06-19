import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class StartupView extends ConsumerStatefulWidget {
  const StartupView({super.key});

  @override
  ConsumerState createState() => _StartupViewState();
}

class _StartupViewState extends ConsumerState<StartupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('View'),
            Text('Startup'),
          ],
        ),
      ),
    );
  }
}
