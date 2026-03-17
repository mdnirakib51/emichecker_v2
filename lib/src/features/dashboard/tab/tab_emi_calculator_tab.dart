
import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_text.dart';
import '../../../global/widget/global_sized_box.dart';
import '../dashboard_shared_widgets.dart';
import '../model/dashboard_utils.dart';

class EmiCalculatorTab extends StatefulWidget {
  const EmiCalculatorTab({super.key});

  @override
  State<EmiCalculatorTab> createState() => _EmiCalculatorTabState();
}

class _EmiCalculatorTabState extends State<EmiCalculatorTab> {
  double _price = 50000;
  double _months = 12;
  double _interest = 10;

  @override
  Widget build(BuildContext context) {
    final monthlyEmi =
    DashboardUtils.calculateEmi(_price, _interest, _months.toInt());
    final totalPayable = monthlyEmi * _months;
    final totalInterest = totalPayable - _price;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSectionHeader(
            title: "EMI Calculator",
            icon: Icons.calculate_rounded,
          ),
          sizedBoxH(12),

          // ── Slider inputs card
          DashboardWhiteCard(
            child: Column(
              children: [
                _SliderInput(
                  label: "Product Price",
                  value: _price,
                  min: 5000,
                  max: 300000,
                  divisions: 59,
                  displayValue: "৳${DashboardUtils.formatAmount(_price)}",
                  onChanged: (v) => setState(() => _price = v),
                ),
                const DashboardDivider(),
                _SliderInput(
                  label: "Tenure (Months)",
                  value: _months,
                  min: 3,
                  max: 36,
                  divisions: 11,
                  displayValue: "${_months.toInt()} months",
                  onChanged: (v) => setState(() => _months = v),
                ),
                const DashboardDivider(),
                _SliderInput(
                  label: "Interest Rate (%)",
                  value: _interest,
                  min: 0,
                  max: 24,
                  divisions: 24,
                  displayValue: "${_interest.toStringAsFixed(0)}%",
                  onChanged: (v) => setState(() => _interest = v),
                ),
              ],
            ),
          ),

          sizedBoxH(16),

          // ── Result card
          _CalcResultCard(
            monthlyEmi: monthlyEmi,
            principal: _price,
            totalInterest: totalInterest,
            totalPayable: totalPayable,
          ),

          sizedBoxH(16),
          DashboardGradientButton(
            label: "Apply for this EMI",
            icon: Icons.arrow_forward_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ── Slider Input Row ───────────────────────────────────────────────────────────
class _SliderInput extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String displayValue;
  final ValueChanged<double> onChanged;

  const _SliderInput({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.displayValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlobalText(
                str: label,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorRes.appColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GlobalText(
                  str: displayValue,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: ColorRes.appColor,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: ColorRes.appColor,
              inactiveTrackColor: ColorRes.appColor.withValues(alpha: 0.1),
              thumbColor: ColorRes.appColor,
              overlayColor: ColorRes.appColor.withValues(alpha: 0.1),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
              trackHeight: 4,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Calculation Result Card ────────────────────────────────────────────────────
class _CalcResultCard extends StatelessWidget {
  final double monthlyEmi;
  final double principal;
  final double totalInterest;
  final double totalPayable;

  const _CalcResultCard({
    required this.monthlyEmi,
    required this.principal,
    required this.totalInterest,
    required this.totalPayable,
  });

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
            color: ColorRes.appColor.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          GlobalText(
            str: "Monthly EMI",
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 6),
          GlobalText(
            str: "৳${DashboardUtils.formatAmount(monthlyEmi)}",
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w800,
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _ResultItem(
                label: "Principal",
                value: "৳${DashboardUtils.formatAmount(principal)}",
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              _ResultItem(
                label: "Interest",
                value: "৳${DashboardUtils.formatAmount(totalInterest)}",
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              _ResultItem(
                label: "Total",
                value: "৳${DashboardUtils.formatAmount(totalPayable)}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultItem extends StatelessWidget {
  final String label;
  final String value;

  const _ResultItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GlobalText(
            str: label,
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 4),
          GlobalText(
            str: value,
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ],
      ),
    );
  }
}