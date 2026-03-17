
import 'package:flutter/material.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/widget/global_sized_box.dart';
import 'components/custom_app_bar.dart';
import 'components/dashboad_bottom_nav.dart';
import 'components/dashboard_profile_card.dart';
import 'model/dashboard_model.dart';
import 'tab/dashboard_feature_tabs.dart';
import 'tab/tab_emi_calculator_tab.dart';
import 'tab/tab_emi_history_tab.dart';
import 'tab/tab_mobile_info_tab.dart';
import 'tab/tab_payment_gateway_tab.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  int _selectedFeatureTab = 0;

  late AnimationController _entryCtrl;
  late Animation<double> _entryAnim;

  // ── Static dummy data (replace with controller/API later)
  static const String _userName = "Rahim Mia";
  static const String _mobileNumber = "+880 1712-345678";
  static const String _customerId = "EMI-2024-00123";
  static const double _totalEmiDue = 12500.00;
  static const double _totalPaid = 34200.00;
  static const int _activeEmis = 3;

  static final List<EmiHistoryModel> _emiList = [
    EmiHistoryModel(
      productName: "Samsung Galaxy S24",
      productIcon: "📱",
      totalAmount: 55000,
      paidAmount: 22000,
      totalMonths: 12,
      paidMonths: 5,
      status: 'active',
      nextDueDate: "25 Mar 2026",
    ),
    EmiHistoryModel(
      productName: "LG 43\" Smart TV",
      productIcon: "📺",
      totalAmount: 42000,
      paidAmount: 42000,
      totalMonths: 6,
      paidMonths: 6,
      status: 'completed',
      nextDueDate: "—",
    ),
    EmiHistoryModel(
      productName: "Dell Laptop Inspiron",
      productIcon: "💻",
      totalAmount: 75000,
      paidAmount: 18750,
      totalMonths: 18,
      paidMonths: 5,
      status: 'active',
      nextDueDate: "01 Apr 2026",
    ),
    EmiHistoryModel(
      productName: "iPhone 15 Pro",
      productIcon: "📱",
      totalAmount: 130000,
      paidAmount: 0,
      totalMonths: 24,
      paidMonths: 0,
      status: 'overdue',
      nextDueDate: "10 Mar 2026",
    ),
  ];

  static final List<PaymentModel> _payments = [
    PaymentModel(
      title: "Samsung EMI — March",
      amount: 4583,
      date: "14 Mar 2026",
      type: "debit",
      method: "bKash",
    ),
    PaymentModel(
      title: "Dell EMI — March",
      amount: 4166,
      date: "01 Mar 2026",
      type: "debit",
      method: "Nagad",
    ),
    PaymentModel(
      title: "Cashback Received",
      amount: 250,
      date: "28 Feb 2026",
      type: "credit",
      method: "System",
    ),
    PaymentModel(
      title: "LG TV — Final EMI",
      amount: 7000,
      date: "20 Feb 2026",
      type: "debit",
      method: "Card",
    ),
    PaymentModel(
      title: "iPhone — Late Fee",
      amount: 500,
      date: "15 Feb 2026",
      type: "debit",
      method: "bKash",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _entryAnim =
        CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    super.dispose();
  }

  void _onFeatureTabChanged(int index) {
    setState(() => _selectedFeatureTab = index);
    _entryCtrl.reset();
    _entryCtrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorRes.appBackColor,
      body: Stack(
        children: [
          // ── Header gradient background
          _HeaderBackground(height: h * 0.28),

          // ── Main content
          SafeArea(
            child: Column(
              children: [
                // AppBar
                CustomAppBar(userName: _userName),

                // Scrollable body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // Profile card
                        DashboardProfileCard(
                          userName: _userName,
                          mobileNumber: _mobileNumber,
                          customerId: _customerId,
                          activeEmis: _activeEmis,
                          totalPaid: _totalPaid,
                          totalEmiDue: _totalEmiDue,
                        ),
                        sizedBoxH(20),

                        // Feature tabs
                        DashboardFeatureTabs(
                          selectedIndex: _selectedFeatureTab,
                          onTabSelected: _onFeatureTabChanged,
                        ),
                        sizedBoxH(16),

                        // Tab content with animated transition
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          transitionBuilder: (child, anim) => FadeTransition(
                            opacity: anim,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.05),
                                end: Offset.zero,
                              ).animate(anim),
                              child: child,
                            ),
                          ),
                          child: _buildActiveTab(),
                        ),

                        // Bottom padding for nav bar
                        sizedBoxH(100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom nav bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DashboardBottomNav(
              initialIndex: 0,
              onItemSelected: (index) {
                // Navigate to other screens here
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTab() {
    switch (_selectedFeatureTab) {
      case 0:
        return MobileInfoTab(
          key: const ValueKey(0),
          userName: _userName,
          mobileNumber: _mobileNumber,
          customerId: _customerId,
        );
      case 1:
        return EmiHistoryTab(
          key: const ValueKey(1),
          emiList: _emiList,
        );
      case 2:
        return PaymentGatewayTab(
          key: const ValueKey(2),
          payments: _payments,
        );
      case 3:
        return const EmiCalculatorTab(key: ValueKey(3));
      default:
        return const SizedBox.shrink(key: ValueKey(-1));
    }
  }
}

// ── Header gradient background widget ─────────────────────────────────────────
class _HeaderBackground extends StatelessWidget {
  final double height;

  const _HeaderBackground({required this.height});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorRes.appColor,
              const Color(0xFF283593),
              const Color(0xFF3949AB),
            ],
          ),
        ),
        child: CustomPaint(painter: _HeaderCircuitPainter()),
      ),
    );
  }
}

// ── Header circuit grid painter ────────────────────────────────────────────────
class _HeaderCircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    for (double y = 20; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
    for (double x = 30; x < size.width; x += 60) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
      for (double y = 20; y < size.height; y += 28) {
        canvas.drawCircle(Offset(x, y), 2, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}