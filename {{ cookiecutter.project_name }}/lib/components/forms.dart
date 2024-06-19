import 'package:flutter/material.dart';

class FieldRequiredText extends StatelessWidget {
  const FieldRequiredText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          SizedBox(height: 5),
          Text(
            'Required',
            style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class FieldDescriptionText extends StatelessWidget {
  final String text;
  const FieldDescriptionText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            text,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
