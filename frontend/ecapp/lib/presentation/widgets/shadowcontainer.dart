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
        color: color ?? Color.fromARGB(255, 245, 245, 245),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1.5)
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.4),
        //     blurRadius:2 ,
        //     offset: Offset(0, 0),
        //   ),
        //],
      ),

      child: child,
    );
  }
}
