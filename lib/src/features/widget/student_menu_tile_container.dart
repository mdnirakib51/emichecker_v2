
import 'package:flutter/material.dart';

class StudentMenuTileContainer extends StatelessWidget {
  const StudentMenuTileContainer({
    super.key,
    this.child,
    this.color,
  });
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 8),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: color?.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}