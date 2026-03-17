
import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_text.dart';
import '../model/dashboard_utils.dart';

class DashboardProfileCard extends StatelessWidget {
  final String userName;
  final String mobileNumber;
  final String customerId;
  final int activeEmis;
  final double totalPaid;
  final double totalEmiDue;

  const DashboardProfileCard({
    super.key,
    required this.userName,
    required this.mobileNumber,
    required this.customerId,
    required this.activeEmis,
    required this.totalPaid,
    required this.totalEmiDue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: ColorRes.appColor.withValues(alpha: 0.12),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── Profile row
            _ProfileRow(
              userName: userName,
              mobileNumber: mobileNumber,
              customerId: customerId,
            ),
            const SizedBox(height: 18),
            Container(height: 1, color: Colors.grey.shade100),
            const SizedBox(height: 16),
            // ── Stats row
            Row(
              children: [
                _StatItem(
                  label: "Active EMIs",
                  value: "$activeEmis",
                  icon: Icons.loop_rounded,
                  color: ColorRes.appColor,
                ),
                _StatDivider(),
                _StatItem(
                  label: "Total Paid",
                  value: "৳${DashboardUtils.formatAmount(totalPaid)}",
                  icon: Icons.check_circle_outline_rounded,
                  color: const Color(0xFF4CAF50),
                ),
                _StatDivider(),
                _StatItem(
                  label: "Due Amount",
                  value: "৳${DashboardUtils.formatAmount(totalEmiDue)}",
                  icon: Icons.pending_actions_rounded,
                  color: const Color(0xFFF57C00),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Profile top row ───────────────────────────────────────────────────────────
class _ProfileRow extends StatelessWidget {
  final String userName;
  final String mobileNumber;
  final String customerId;

  const _ProfileRow({
    required this.userName,
    required this.mobileNumber,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [ColorRes.appColor, Color(0xFF3949AB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: GlobalText(
              str: userName.isNotEmpty ? userName.substring(0, 1) : '?',
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 14),

        // Name + phone + ID
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalText(
                str: userName,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1A1A2E),
              ),
              const SizedBox(height: 3),
              _IconText(
                icon: Icons.phone_android_rounded,
                text: mobileNumber,
              ),
              const SizedBox(height: 2),
              _IconText(
                icon: Icons.badge_outlined,
                text: customerId,
                fontSize: 11,
              ),
            ],
          ),
        ),

        // Active status badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF4CAF50).withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              GlobalText(
                str: 'Active',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2E7D32),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final double fontSize;

  const _IconText({
    required this.icon,
    required this.text,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12,
          color: ColorRes.appColor.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 4),
        GlobalText(
          str: text,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade600,
        ),
      ],
    );
  }
}

// ── Single stat item ──────────────────────────────────────────────────────────
class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 6),
          GlobalText(
            str: value,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1A1A2E),
          ),
          const SizedBox(height: 2),
          GlobalText(
            str: label,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 50,
      color: Colors.grey.shade100,
      margin: const EdgeInsets.symmetric(horizontal: 6),
    );
  }
}