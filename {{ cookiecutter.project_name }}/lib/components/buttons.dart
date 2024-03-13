import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


/// Loading animation when a button is pressed
class ButtonLoading extends StatelessWidget {
  final Color? color;
  const ButtonLoading({this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color ?? Theme.of(context).colorScheme.onPrimary,
      size: 20,
    );
  }
}
