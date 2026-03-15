import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/widget/global_text.dart';
import '../../global/widget/global_sized_box.dart';

// ─── Dummy Data Models ────────────────────────────────────────────────────────

class EmiHistoryModel {
  final String productName;
  final String productIcon;
  final double totalAmount;
  final double paidAmount;
  final int totalMonths;
  final int paidMonths;
  final String status; // 'active' | 'completed' | 'overdue'
  final String nextDueDate;

  EmiHistoryModel({
    required this.productName,
    required this.productIcon,
    required this.totalAmount,
    required this.paidAmount,
    required this.totalMonths,
    required this.paidMonths,
    required this.status,
    required this.nextDueDate,
  });
}

class PaymentModel {
  final String title;
  final double amount;
  final String date;
  final String type; // 'credit' | 'debit'
  final String method;

  PaymentModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.method,
  });
}

// ─── Dashboard Screen ─────────────────────────────────────────────────────────

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  int _selectedTab = 0;

  late AnimationController _headerPulseCtrl;
  late AnimationController _cardEntryCtrl;
  late Animation<double> _headerPulse;
  late Animation<double> _cardEntry;

  // ── Dummy data
  final String userName = "Rahim Mia";
  final String mobileNumber = "+880 1712-345678";
  final String customerId = "EMI-2024-00123";
  final double totalEmiDue = 12500.00;
  final double totalPaid = 34200.00;
  final int activeEmis = 3;

  final List<EmiHistoryModel> emiList = [
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

  final List<PaymentModel> payments = [
    PaymentModel(
        title: "Samsung EMI — March",
        amount: 4583,
        date: "14 Mar 2026",
        type: "debit",
        method: "bKash"),
    PaymentModel(
        title: "Dell EMI — March",
        amount: 4166,
        date: "01 Mar 2026",
        type: "debit",
        method: "Nagad"),
    PaymentModel(
        title: "Cashback Received",
        amount: 250,
        date: "28 Feb 2026",
        type: "credit",
        method: "System"),
    PaymentModel(
        title: "LG TV — Final EMI",
        amount: 7000,
        date: "20 Feb 2026",
        type: "debit",
        method: "Card"),
    PaymentModel(
        title: "iPhone — Late Fee",
        amount: 500,
        date: "15 Feb 2026",
        type: "debit",
        method: "bKash"),
  ];

  @override
  void initState() {
    super.initState();

    _headerPulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _headerPulse = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _headerPulseCtrl, curve: Curves.easeInOutSine),
    );

    _cardEntryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _cardEntry = CurvedAnimation(parent: _cardEntryCtrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _headerPulseCtrl.dispose();
    _cardEntryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorRes.appBackColor,
      body: Stack(
        children: [
          // ── Header gradient background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: h * 0.28,
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
              child: CustomPaint(
                painter: _HeaderCircuitPainter(),
              ),
            ),
          ),

          // ── Main scrollable content
          SafeArea(
            child: Column(
              children: [
                // ── Top bar
                _buildTopBar(),
                // ── Scrollable body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // Profile + summary card
                        _buildProfileSummaryCard(w),
                        sizedBoxH(20),
                        // 4 feature tabs
                        _buildFeatureTabs(w),
                        sizedBoxH(16),
                        // Tab content
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
                          child: _buildTabContent(key: ValueKey(_selectedTab)),
                        ),
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
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  // ─── Top Bar ──────────────────────────────────────────────────────────────
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Brand
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3), width: 1),
                ),
                child: const Icon(Icons.electric_bolt_rounded,
                    color: Colors.white, size: 16),
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
          // Notification + Profile
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.notifications_outlined,
                        color: Colors.white, size: 20),
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
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                  Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: GlobalText(
                    str: userName.substring(0, 1),
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Profile Summary Card ─────────────────────────────────────────────────
  Widget _buildProfileSummaryCard(double w) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // User info card (overlapping header)
          Container(
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
                // Profile row
                Row(
                  children: [
                    // Avatar
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorRes.appColor,
                            const Color(0xFF3949AB),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: GlobalText(
                          str: userName.substring(0, 1),
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
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
                          Row(
                            children: [
                              Icon(Icons.phone_android_rounded,
                                  size: 12,
                                  color:
                                  ColorRes.appColor.withValues(alpha: 0.6)),
                              const SizedBox(width: 4),
                              GlobalText(
                                str: mobileNumber,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(Icons.badge_outlined,
                                  size: 12,
                                  color:
                                  ColorRes.appColor.withValues(alpha: 0.6)),
                              const SizedBox(width: 4),
                              GlobalText(
                                str: customerId,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFF4CAF50).withValues(alpha: 0.4)),
                      ),
                      child: Row(
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
                ),

                const SizedBox(height: 18),
                // Divider
                Container(height: 1, color: Colors.grey.shade100),
                const SizedBox(height: 16),

                // Summary stats row
                Row(
                  children: [
                    _buildStatItem(
                        label: "Active EMIs",
                        value: "$activeEmis",
                        icon: Icons.loop_rounded,
                        color: ColorRes.appColor),
                    _buildStatDivider(),
                    _buildStatItem(
                        label: "Total Paid",
                        value: "৳${_formatAmount(totalPaid)}",
                        icon: Icons.check_circle_outline_rounded,
                        color: const Color(0xFF4CAF50)),
                    _buildStatDivider(),
                    _buildStatItem(
                        label: "Due Amount",
                        value: "৳${_formatAmount(totalEmiDue)}",
                        icon: Icons.pending_actions_rounded,
                        color: const Color(0xFFF57C00)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
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

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 50,
      color: Colors.grey.shade100,
      margin: const EdgeInsets.symmetric(horizontal: 6),
    );
  }

  // ─── Feature Tabs ──────────────────────────────────────────────────────────
  Widget _buildFeatureTabs(double w) {
    final tabs = [
      {'icon': Icons.phone_android_rounded, 'label': 'Mobile'},
      {'icon': Icons.history_rounded, 'label': 'History'},
      {'icon': Icons.payment_rounded, 'label': 'Payment'},
      {'icon': Icons.calculate_rounded, 'label': 'Calculate'},
    ];

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
          children: List.generate(tabs.length, (i) {
            final isSelected = _selectedTab == i;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => _selectedTab = i);
                  _cardEntryCtrl.reset();
                  _cardEntryCtrl.forward();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color:
                    isSelected ? ColorRes.appColor : Colors.transparent,
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
                        tabs[i]['icon'] as IconData,
                        size: 18,
                        color: isSelected
                            ? Colors.white
                            : Colors.grey.shade500,
                      ),
                      const SizedBox(height: 3),
                      GlobalText(
                        str: tabs[i]['label'] as String,
                        fontSize: 10,
                        fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : Colors.grey.shade500,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ─── Tab Content Router ───────────────────────────────────────────────────
  Widget _buildTabContent({Key? key}) {
    switch (_selectedTab) {
      case 0:
        return _buildMobileInfoTab(key: key);
      case 1:
        return _buildEmiHistoryTab(key: key);
      case 2:
        return _buildPaymentGatewayTab(key: key);
      case 3:
        return _buildEmiCalculatorTab(key: key);
      default:
        return const SizedBox(key: Key('empty'));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // TAB 1 — Mobile / Customer Info
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildMobileInfoTab({Key? key}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
              title: "Customer Details",
              icon: Icons.person_pin_rounded),
          sizedBoxH(12),

          // Info card
          _buildWhiteCard(
            child: Column(
              children: [
                _buildInfoRow(
                    icon: Icons.person_rounded,
                    label: "Full Name",
                    value: userName),
                _buildInfoDivider(),
                _buildInfoRow(
                    icon: Icons.phone_android_rounded,
                    label: "Mobile Number",
                    value: mobileNumber),
                _buildInfoDivider(),
                _buildInfoRow(
                    icon: Icons.badge_outlined,
                    label: "Customer ID",
                    value: customerId),
                _buildInfoDivider(),
                _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    label: "Address",
                    value: "Mirpur-10, Dhaka-1216"),
                _buildInfoDivider(),
                _buildInfoRow(
                    icon: Icons.email_outlined,
                    label: "Email",
                    value: "rahim.mia@gmail.com"),
                _buildInfoDivider(),
                _buildInfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: "Member Since",
                    value: "January 2023"),
              ],
            ),
          ),

          sizedBoxH(16),
          _buildSectionHeader(
              title: "Linked Numbers", icon: Icons.sim_card_rounded),
          sizedBoxH(12),

          _buildWhiteCard(
            child: Column(
              children: [
                _buildSimRow(
                    number: "+880 1712-345678",
                    operator: "Grameenphone",
                    isPrimary: true),
                _buildInfoDivider(),
                _buildSimRow(
                    number: "+880 1811-987654",
                    operator: "Robi",
                    isPrimary: false),
              ],
            ),
          ),

          sizedBoxH(16),
          // Edit profile button
          _buildGradientButton(
            label: "Edit Profile",
            icon: Icons.edit_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      {required IconData icon,
        required String label,
        required String value}) {
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

  Widget _buildSimRow(
      {required String number,
        required String operator,
        required bool isPrimary}) {
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
            child: Icon(Icons.sim_card_rounded,
                size: 15, color: ColorRes.appColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  str: number,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A2E),
                ),
                GlobalText(
                  str: operator,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ),
          if (isPrimary)
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: ColorRes.appColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: GlobalText(
                str: "Primary",
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: ColorRes.appColor,
              ),
            ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // TAB 2 — EMI History
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildEmiHistoryTab({Key? key}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
              title: "EMI History", icon: Icons.history_rounded),
          sizedBoxH(12),
          ...emiList.map((emi) => _buildEmiCard(emi)),
        ],
      ),
    );
  }

  Widget _buildEmiCard(EmiHistoryModel emi) {
    final statusColor = emi.status == 'completed'
        ? const Color(0xFF4CAF50)
        : emi.status == 'overdue'
        ? const Color(0xFFF44336)
        : ColorRes.appColor;

    final statusLabel = emi.status == 'completed'
        ? 'Completed'
        : emi.status == 'overdue'
        ? 'Overdue'
        : 'Active';

    final progress =
    emi.totalMonths > 0 ? emi.paidMonths / emi.totalMonths : 0.0;

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
          Row(
            children: [
              // Product icon
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(emi.productIcon,
                      style: const TextStyle(fontSize: 22)),
                ),
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
                      "৳${_formatAmount(emi.totalAmount)} • ${emi.totalMonths} months",
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
              // Status chip
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border:
                  Border.all(color: statusColor.withValues(alpha: 0.3)),
                ),
                child: GlobalText(
                  str: statusLabel,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: statusColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Progress bar
          Row(
            children: [
              GlobalText(
                str:
                "${emi.paidMonths}/${emi.totalMonths} paid",
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
              const Spacer(),
              GlobalText(
                str:
                "${(progress * 100).toStringAsFixed(0)}%",
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: statusColor,
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              minHeight: 6,
            ),
          ),

          const SizedBox(height: 12),

          // Amount + next due row
          Row(
            children: [
              _buildEmiMetric(
                  label: "Paid",
                  value: "৳${_formatAmount(emi.paidAmount)}",
                  color: const Color(0xFF4CAF50)),
              const SizedBox(width: 10),
              _buildEmiMetric(
                  label: "Remaining",
                  value:
                  "৳${_formatAmount(emi.totalAmount - emi.paidAmount)}",
                  color: const Color(0xFFF57C00)),
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

  Widget _buildEmiMetric(
      {required String label,
        required String value,
        required Color color}) {
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

  // ─────────────────────────────────────────────────────────────────────────
  // TAB 3 — Payment Gateway
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildPaymentGatewayTab({Key? key}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Pay card
          _buildSectionHeader(
              title: "Quick Pay EMI", icon: Icons.flash_on_rounded),
          sizedBoxH(12),
          _buildQuickPayCard(),

          sizedBoxH(18),
          _buildSectionHeader(
              title: "Payment Methods", icon: Icons.credit_card_rounded),
          sizedBoxH(12),
          _buildPaymentMethods(),

          sizedBoxH(18),
          _buildSectionHeader(
              title: "Recent Transactions",
              icon: Icons.receipt_long_rounded),
          sizedBoxH(12),
          ...payments.map((p) => _buildTransactionRow(p)),
        ],
      ),
    );
  }

  Widget _buildQuickPayCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorRes.appColor,
            const Color(0xFF3949AB),
          ],
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
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  Icon(Icons.payment_rounded,
                      color: ColorRes.appColor, size: 18),
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

  Widget _buildPaymentMethods() {
    final methods = [
      {'label': 'bKash', 'color': const Color(0xFFE2136E), 'icon': '💳'},
      {'label': 'Nagad', 'color': const Color(0xFFFF6600), 'icon': '📲'},
      {'label': 'Rocket', 'color': const Color(0xFF8B1FA8), 'icon': '🚀'},
      {'label': 'Card', 'color': const Color(0xFF1565C0), 'icon': '💳'},
    ];

    return Row(
      children: methods.map((m) {
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
                    color: (m['color'] as Color).withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(m['icon'] as String,
                      style: const TextStyle(fontSize: 22)),
                  const SizedBox(height: 6),
                  GlobalText(
                    str: m['label'] as String,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: m['color'] as Color,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTransactionRow(PaymentModel payment) {
    final isCredit = payment.type == 'credit';
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (isCredit
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFF57C00))
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isCredit
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              size: 16,
              color: isCredit
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFF57C00),
            ),
          ),
          const SizedBox(width: 12),
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
          GlobalText(
            str: "${isCredit ? '+' : '-'}৳${_formatAmount(payment.amount)}",
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: isCredit
                ? const Color(0xFF4CAF50)
                : const Color(0xFF1A1A2E),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // TAB 4 — EMI Calculator
  // ─────────────────────────────────────────────────────────────────────────
  double _calcPrice = 50000;
  double _calcMonths = 12;
  double _calcInterest = 10;

  Widget _buildEmiCalculatorTab({Key? key}) {
    return StatefulBuilder(
      key: key,
      builder: (context, localSetState) {
        final monthlyEmi =
        _calculateEmi(_calcPrice, _calcInterest, _calcMonths.toInt());
        final totalPayable = monthlyEmi * _calcMonths;
        final totalInterest = totalPayable - _calcPrice;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(
                  title: "EMI Calculator",
                  icon: Icons.calculate_rounded),
              sizedBoxH(12),

              _buildWhiteCard(
                child: Column(
                  children: [
                    // Product Price slider
                    _buildSliderInput(
                      label: "Product Price",
                      value: _calcPrice,
                      min: 5000,
                      max: 300000,
                      divisions: 59,
                      displayValue:
                      "৳${_formatAmount(_calcPrice)}",
                      onChanged: (v) =>
                          localSetState(() => _calcPrice = v),
                    ),
                    _buildInfoDivider(),
                    // Months slider
                    _buildSliderInput(
                      label: "Tenure (Months)",
                      value: _calcMonths,
                      min: 3,
                      max: 36,
                      divisions: 11,
                      displayValue: "${_calcMonths.toInt()} months",
                      onChanged: (v) =>
                          localSetState(() => _calcMonths = v),
                    ),
                    _buildInfoDivider(),
                    // Interest slider
                    _buildSliderInput(
                      label: "Interest Rate (%)",
                      value: _calcInterest,
                      min: 0,
                      max: 24,
                      divisions: 24,
                      displayValue:
                      "${_calcInterest.toStringAsFixed(0)}%",
                      onChanged: (v) =>
                          localSetState(() => _calcInterest = v),
                    ),
                  ],
                ),
              ),

              sizedBoxH(16),

              // Results card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorRes.appColor,
                      const Color(0xFF3949AB),
                    ],
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
                      str: "৳${_formatAmount(monthlyEmi)}",
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        _buildCalcResult(
                          label: "Principal",
                          value: "৳${_formatAmount(_calcPrice)}",
                        ),
                        Container(
                            width: 1,
                            height: 40,
                            color: Colors.white.withValues(alpha: 0.2)),
                        _buildCalcResult(
                          label: "Interest",
                          value:
                          "৳${_formatAmount(totalInterest)}",
                        ),
                        Container(
                            width: 1,
                            height: 40,
                            color: Colors.white.withValues(alpha: 0.2)),
                        _buildCalcResult(
                          label: "Total",
                          value:
                          "৳${_formatAmount(totalPayable)}",
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              sizedBoxH(16),
              _buildGradientButton(
                label: "Apply for this EMI",
                icon: Icons.arrow_forward_rounded,
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSliderInput({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String displayValue,
    required ValueChanged<double> onChanged,
  }) {
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
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
              thumbShape:
              const RoundSliderThumbShape(enabledThumbRadius: 7),
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

  Widget _buildCalcResult(
      {required String label, required String value}) {
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

  // ─────────────────────────────────────────────────────────────────────────
  // Shared Helpers
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildSectionHeader(
      {required String title, required IconData icon}) {
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

  Widget _buildWhiteCard({required Widget child}) {
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

  Widget _buildInfoDivider() {
    return Divider(height: 1, color: Colors.grey.shade100);
  }

  Widget _buildGradientButton(
      {required String label,
        required IconData icon,
        required VoidCallback onTap}) {
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

  // ─── Bottom Nav Bar ───────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    final navItems = [
      {'icon': Icons.dashboard_rounded, 'label': 'Dashboard'},
      {'icon': Icons.shopping_bag_rounded, 'label': 'Products'},
      {'icon': Icons.receipt_long_rounded, 'label': 'Orders'},
      {'icon': Icons.person_rounded, 'label': 'Profile'},
    ];

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
        borderRadius:
        const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: List.generate(navItems.length, (i) {
          final isActive = i == 0;
          return Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? ColorRes.appColor.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      navItems[i]['icon'] as IconData,
                      size: 22,
                      color: isActive
                          ? ColorRes.appColor
                          : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 3),
                  GlobalText(
                    str: navItems[i]['label'] as String,
                    fontSize: 10,
                    fontWeight:
                    isActive ? FontWeight.w700 : FontWeight.w400,
                    color: isActive
                        ? ColorRes.appColor
                        : Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // ─── Utility ─────────────────────────────────────────────────────────────
  String _formatAmount(double amount) {
    if (amount >= 1000) {
      final formatted = amount.toStringAsFixed(0);
      final result = StringBuffer();
      int count = 0;
      for (int i = formatted.length - 1; i >= 0; i--) {
        if (count > 0 && count % 3 == 0) result.write(',');
        result.write(formatted[i]);
        count++;
      }
      return result.toString().split('').reversed.join('');
    }
    return amount.toStringAsFixed(0);
  }

  double _calculateEmi(double principal, double annualRate, int months) {
    if (annualRate == 0) return principal / months;
    final r = annualRate / 12 / 100;
    final emi =
        principal * r * (1 + r).pow(months) / ((1 + r).pow(months) - 1);
    return emi;
  }
}

// ─── Header Circuit Painter ───────────────────────────────────────────────────
class _HeaderCircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Horizontal lines
    for (double y = 20; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
    // Vertical lines
    for (double x = 30; x < size.width; x += 60) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }

    // Node dots
    final dot = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;
    for (double x = 30; x < size.width; x += 60) {
      for (double y = 20; y < size.height; y += 28) {
        canvas.drawCircle(Offset(x, y), 2, dot);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Extension for pow on num ─────────────────────────────────────────────────
extension NumPow on double {
  double pow(int exp) {
    double result = 1;
    for (int i = 0; i < exp; i++) {
      result *= this;
    }
    return result;
  }
}