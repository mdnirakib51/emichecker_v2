
import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_text.dart';
import '../../../global/widget/global_sized_box.dart';
import '../dashboard_shared_widgets.dart';
import '../model/dashboard_model.dart';
import '../model/dashboard_utils.dart';

class PaymentGatewayTab extends StatelessWidget {
  final List<PaymentModel> payments;

  const PaymentGatewayTab({
    super.key,
    required this.payments,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Quick Pay
          const DashboardSectionHeader(
            title: "Quick Pay EMI",
            icon: Icons.flash_on_rounded,
          ),
          sizedBoxH(12),
          const QuickPayCard(),

          sizedBoxH(18),

          // ── Payment methods
          const DashboardSectionHeader(
            title: "Payment Methods",
            icon: Icons.credit_card_rounded,
          ),
          sizedBoxH(12),
          const PaymentMethodsRow(),

          sizedBoxH(18),

          // ── Recent transactions
          const DashboardSectionHeader(
            title: "Recent Transactions",
            icon: Icons.receipt_long_rounded,
          ),
          sizedBoxH(12),
          ...payments.map((p) => TransactionRow(payment: p)),
        ],
      ),
    );
  }
}

// ── Quick Pay Card ─────────────────────────────────────────────────────────────
class QuickPayCard extends StatelessWidget {
  const QuickPayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorRes.appColor, Color(0xFF3949AB)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: ColorRes.appColor.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlobalText(
                str: "Upcoming EMI",
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GlobalText(
                  str: "Due: 25 Mar 2026",
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // ── Amount
          GlobalText(
            str: "৳4,583.00",
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
          const SizedBox(height: 4),
          GlobalText(
            str: "Samsung Galaxy S24 — March Installment",
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 18),

          // ── Pay Now button
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payment_rounded, color: ColorRes.appColor, size: 18),
                  const SizedBox(width: 8),
                  GlobalText(
                    str: "Pay Now",
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: ColorRes.appColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Payment Methods Row ────────────────────────────────────────────────────────
class PaymentMethodsRow extends StatelessWidget {
  const PaymentMethodsRow({super.key});

  static const List<_PayMethod> _methods = [
    _PayMethod(label: 'bKash', color: Color(0xFFE2136E), icon: '💳'),
    _PayMethod(label: 'Nagad', color: Color(0xFFFF6600), icon: '📲'),
    _PayMethod(label: 'Rocket', color: Color(0xFF8B1FA8), icon: '🚀'),
    _PayMethod(label: 'Card', color: Color(0xFF1565C0), icon: '💳'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _methods.map((m) => _PayMethodItem(method: m)).toList(),
    );
  }
}

class _PayMethodItem extends StatelessWidget {
  final _PayMethod method;

  const _PayMethodItem({required this.method});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: method.color.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(method.icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 6),
              GlobalText(
                str: method.label,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: method.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PayMethod {
  final String label;
  final Color color;
  final String icon;

  const _PayMethod({
    required this.label,
    required this.color,
    required this.icon,
  });
}

// ── Transaction Row ────────────────────────────────────────────────────────────
class TransactionRow extends StatelessWidget {
  final PaymentModel payment;

  const TransactionRow({super.key, required this.payment});

  bool get _isCredit => payment.type == 'credit';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Direction icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (_isCredit
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFF57C00))
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _isCredit
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              size: 16,
              color: _isCredit
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFF57C00),
            ),
          ),
          const SizedBox(width: 12),

          // ── Title + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  str: payment.title,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A2E),
                ),
                GlobalText(
                  str: "${payment.date} • ${payment.method}",
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ),

          // ── Amount
          GlobalText(
            str:
            "${_isCredit ? '+' : '-'}৳${DashboardUtils.formatAmount(payment.amount)}",
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: _isCredit
                ? const Color(0xFF4CAF50)
                : const Color(0xFF1A1A2E),
          ),
        ],
      ),
    );
  }
}