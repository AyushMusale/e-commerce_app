import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final Widget child;

  const ShadowContainer({super.key, required this.child, this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black, width: 1),
      ),

      child: child,
    );
  }
}
