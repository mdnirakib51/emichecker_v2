
import 'package:flutter/material.dart';

import '../../global/constants/colors_resources.dart';
import '../../global/widget/global_text.dart';

class DashboardSectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const DashboardSectionHeader({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: ColorRes.appColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, size: 16, color: ColorRes.appColor),
        const SizedBox(width: 6),
        GlobalText(
          str: title,
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF1A1A2E),
        ),
      ],
    );
  }
}

// ── White Card Container ───────────────────────────────────────────────────────
class DashboardWhiteCard extends StatelessWidget {
  final Widget child;

  const DashboardWhiteCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorRes.appColor.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ── Gradient Button ────────────────────────────────────────────────────────────
class DashboardGradientButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardGradientButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorRes.appColor,
              ColorRes.appColor.withValues(alpha: 0.8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: ColorRes.appColor.withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalText(
              str: label,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Icon(icon, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}

// ── Thin Divider ───────────────────────────────────────────────────────────────
class DashboardDivider extends StatelessWidget {
  const DashboardDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, color: Colors.grey.shade100);
  }
}

// ── Info Row (icon + label + value) ───────────────────────────────────────────
class DashboardInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DashboardInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: ColorRes.appColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 15, color: ColorRes.appColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  str: label,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(height: 2),
                GlobalText(
                  str: value,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A2E),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}