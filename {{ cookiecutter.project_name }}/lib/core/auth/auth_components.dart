import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class RegisterHereText extends StatelessWidget {
  const RegisterHereText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('No account yet?', style: TextStyle(color: Colors.grey)),
        TextButton(
          onPressed: () => context.goNamed('register'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 7),
          ),
          child: const Text('Register here.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              )),
        ),
      ],
    );
  }
}
