
import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_text.dart';

class DashboardBottomNav extends StatefulWidget {
  /// Callback যখন কোনো item select হয়
  final ValueChanged<int> onItemSelected;

  /// বাইরে থেকে initial index দেওয়া যাবে
  final int initialIndex;

  const DashboardBottomNav({
    super.key,
    required this.onItemSelected,
    this.initialIndex = 0,
  });

  @override
  State<DashboardBottomNav> createState() => _DashboardBottomNavState();
}

class _DashboardBottomNavState extends State<DashboardBottomNav> {
  late int _activeIndex;

  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
    _NavItem(icon: Icons.shopping_bag_rounded, label: 'Products'),
    _NavItem(icon: Icons.receipt_long_rounded, label: 'Orders'),
    _NavItem(icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.initialIndex;
  }

  void _onTap(int index) {
    if (_activeIndex == index) return;
    setState(() => _activeIndex = index);
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: List.generate(_items.length, (i) {
          return _NavBarItem(
            item: _items[i],
            isActive: _activeIndex == i,
            onTap: () => _onTap(i),
          );
        }),
      ),
    );
  }
}

// ── Single nav item ────────────────────────────────────────────────────────────
class _NavBarItem extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isActive
                    ? ColorRes.appColor.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                item.icon,
                size: 22,
                color: isActive ? ColorRes.appColor : Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 3),
            GlobalText(
              str: item.label,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: isActive ? ColorRes.appColor : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Data class for nav items ───────────────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}