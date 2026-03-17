
import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_text.dart';
import '../../../global/widget/global_sized_box.dart';
import '../dashboard_shared_widgets.dart';

class MobileInfoTab extends StatelessWidget {
  final String userName;
  final String mobileNumber;
  final String customerId;

  const MobileInfoTab({
    super.key,
    required this.userName,
    required this.mobileNumber,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSectionHeader(
            title: "Customer Details",
            icon: Icons.person_pin_rounded,
          ),
          sizedBoxH(12),

          // ── Customer info card
          DashboardWhiteCard(
            child: Column(
              children: [
                DashboardInfoRow(
                  icon: Icons.person_rounded,
                  label: "Full Name",
                  value: userName,
                ),
                const DashboardDivider(),
                DashboardInfoRow(
                  icon: Icons.phone_android_rounded,
                  label: "Mobile Number",
                  value: mobileNumber,
                ),
                const DashboardDivider(),
                DashboardInfoRow(
                  icon: Icons.badge_outlined,
                  label: "Customer ID",
                  value: customerId,
                ),
                const DashboardDivider(),
                const DashboardInfoRow(
                  icon: Icons.location_on_outlined,
                  label: "Address",
                  value: "Mirpur-10, Dhaka-1216",
                ),
                const DashboardDivider(),
                const DashboardInfoRow(
                  icon: Icons.email_outlined,
                  label: "Email",
                  value: "rahim.mia@gmail.com",
                ),
                const DashboardDivider(),
                const DashboardInfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: "Member Since",
                  value: "January 2023",
                ),
              ],
            ),
          ),

          sizedBoxH(16),
          const DashboardSectionHeader(
            title: "Linked Numbers",
            icon: Icons.sim_card_rounded,
          ),
          sizedBoxH(12),

          // ── SIM card list
          DashboardWhiteCard(
            child: Column(
              children: const [
                _SimRow(
                  number: "+880 1712-345678",
                  operator: "Grameenphone",
                  isPrimary: true,
                ),
                DashboardDivider(),
                _SimRow(
                  number: "+880 1811-987654",
                  operator: "Robi",
                  isPrimary: false,
                ),
              ],
            ),
          ),

          sizedBoxH(16),
          DashboardGradientButton(
            label: "Edit Profile",
            icon: Icons.edit_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ── SIM row ────────────────────────────────────────────────────────────────────
class _SimRow extends StatelessWidget {
  final String number;
  final String operator;
  final bool isPrimary;

  const _SimRow({
    required this.number,
    required this.operator,
    required this.isPrimary,
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
            child: Icon(
              Icons.sim_card_rounded,
              size: 15,
              color: ColorRes.appColor,
            ),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
}