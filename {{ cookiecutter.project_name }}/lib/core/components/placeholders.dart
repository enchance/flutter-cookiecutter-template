import 'package:flutter/material.dart';


class MastheadPlaceholderImage extends StatelessWidget {
  const MastheadPlaceholderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      color: Colors.grey.shade300,
      child: const Icon(Icons.image_rounded, size: 100, color: Colors.grey),
    );
  }
}
