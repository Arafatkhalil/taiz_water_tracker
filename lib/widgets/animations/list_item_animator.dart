// lib/widgets/animations/list_item_animator.dart
import 'package:flutter/material.dart';

class ListItemAnimator extends StatelessWidget {
  final Widget child;

  const ListItemAnimator({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuad,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, double value, _) {
        return Opacity(
          opacity: value,
          // تحريك العنصر من الأسفل إلى الأعلى بناءً على قيمة الأنيميشن
          child: Transform.translate(
            offset: Offset(0.0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }
}
