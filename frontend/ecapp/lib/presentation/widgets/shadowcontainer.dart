import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;

  const ShadowContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        //border: Border.all(color: Colors.grey, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
           blurRadius:2 ,
            offset: Offset(0, 0),
          ),
        ],
      ),

      child: child,
    );
  }
}
