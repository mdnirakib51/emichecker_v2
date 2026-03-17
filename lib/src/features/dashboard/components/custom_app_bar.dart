
import 'package:flutter/material.dart';
import '../../../global/widget/global_text.dart';

class CustomAppBar extends StatelessWidget {
  final String userName;

  const CustomAppBar({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ── Brand chip
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.electric_bolt_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              GlobalText(
                str: 'EMI Store',
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ],
          ),

          // ── Actions (notification + avatar)
          Row(
            children: [
              _NotificationBell(),
              const SizedBox(width: 10),
              _UserAvatar(userName: userName),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Notification Bell with red dot ────────────────────────────────────────────
class _NotificationBell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: 20,
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFFF5252),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

// ── User Avatar circle ─────────────────────────────────────────────────────────
class _UserAvatar extends StatelessWidget {
  final String userName;

  const _UserAvatar({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.white.withValues(alpha: 0.2),
        child: GlobalText(
          str: userName.isNotEmpty ? userName.substring(0, 1) : '?',
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}