
import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_text.dart';
import '../../../global/widget/global_sized_box.dart';
import '../dashboard_shared_widgets.dart';
import '../model/dashboard_model.dart';
import '../model/dashboard_utils.dart';

class EmiHistoryTab extends StatelessWidget {
  final List<EmiHistoryModel> emiList;

  const EmiHistoryTab({
    super.key,
    required this.emiList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSectionHeader(
            title: "EMI History",
            icon: Icons.history_rounded,
          ),
          sizedBoxH(12),
          ...emiList.map((emi) => EmiHistoryCard(emi: emi)),
        ],
      ),
    );
  }
}

// ── Single EMI card ────────────────────────────────────────────────────────────
class EmiHistoryCard extends StatelessWidget {
  final EmiHistoryModel emi;

  const EmiHistoryCard({super.key, required this.emi});

  Color get _statusColor {
    if (emi.status == 'completed') return const Color(0xFF4CAF50);
    if (emi.status == 'overdue') return const Color(0xFFF44336);
    return ColorRes.appColor;
  }

  String get _statusLabel {
    if (emi.status == 'completed') return 'Completed';
    if (emi.status == 'overdue') return 'Overdue';
    return 'Active';
  }

  double get _progress =>
      emi.totalMonths > 0 ? emi.paidMonths / emi.totalMonths : 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          // ── Product header row
          Row(
            children: [
              _ProductIconBox(
                icon: emi.productIcon,
                color: _statusColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      str: emi.productName,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                    const SizedBox(height: 3),
                    GlobalText(
                      str:
                      "৳${DashboardUtils.formatAmount(emi.totalAmount)} • ${emi.totalMonths} months",
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
              _StatusChip(label: _statusLabel, color: _statusColor),
            ],
          ),

          const SizedBox(height: 14),

          // ── Progress bar
          Row(
            children: [
              GlobalText(
                str: "${emi.paidMonths}/${emi.totalMonths} paid",
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
              const Spacer(),
              GlobalText(
                str: "${(_progress * 100).toStringAsFixed(0)}%",
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _statusColor,
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(_statusColor),
              minHeight: 6,
            ),
          ),

          const SizedBox(height: 12),

          // ── Amount + next due
          Row(
            children: [
              _EmiMetricChip(
                label: "Paid",
                value: "৳${DashboardUtils.formatAmount(emi.paidAmount)}",
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(width: 10),
              _EmiMetricChip(
                label: "Remaining",
                value:
                "৳${DashboardUtils.formatAmount(emi.totalAmount - emi.paidAmount)}",
                color: const Color(0xFFF57C00),
              ),
              const Spacer(),
              if (emi.status != 'completed')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GlobalText(
                      str: "Next Due",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                    GlobalText(
                      str: emi.nextDueDate,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: emi.status == 'overdue'
                          ? const Color(0xFFF44336)
                          : const Color(0xFF1A1A2E),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Product icon box ──────────────────────────────────────────────────────────
class _ProductIconBox extends StatelessWidget {
  final String icon;
  final Color color;

  const _ProductIconBox({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(icon, style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}

// ── Status chip ────────────────────────────────────────────────────────────────
class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: GlobalText(
        str: label,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}

// ── EMI metric chip ────────────────────────────────────────────────────────────
class _EmiMetricChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _EmiMetricChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalText(
            str: label,
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: color.withValues(alpha: 0.7),
          ),
          GlobalText(
            str: value,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ],
      ),
    );
  }
}