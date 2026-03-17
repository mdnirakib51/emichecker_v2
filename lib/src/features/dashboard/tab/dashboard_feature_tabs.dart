
import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_text.dart';

class DashboardFeatureTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const DashboardFeatureTabs({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  static const List<_TabItem> _tabs = [
    _TabItem(icon: Icons.phone_android_rounded, label: 'Mobile'),
    _TabItem(icon: Icons.history_rounded, label: 'History'),
    _TabItem(icon: Icons.payment_rounded, label: 'Payment'),
    _TabItem(icon: Icons.calculate_rounded, label: 'Calculate'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: ColorRes.appColor.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: List.generate(_tabs.length, (i) {
            return _FeatureTabItem(
              tab: _tabs[i],
              isSelected: selectedIndex == i,
              onTap: () => onTabSelected(i),
            );
          }),
        ),
      ),
    );
  }
}

// ── Single tab item ────────────────────────────────────────────────────────────
class _FeatureTabItem extends StatelessWidget {
  final _TabItem tab;
  final bool isSelected;
  final VoidCallback onTap;

  const _FeatureTabItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? ColorRes.appColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: ColorRes.appColor.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                tab.icon,
                size: 18,
                color: isSelected ? Colors.white : Colors.grey.shade500,
              ),
              const SizedBox(height: 3),
              GlobalText(
                str: tab.label,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Data class ────────────────────────────────────────────────────────────────
class _TabItem {
  final IconData icon;
  final String label;

  const _TabItem({required this.icon, required this.label});
}