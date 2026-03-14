import 'package:flutter/material.dart';
import '../constants/colors_resources.dart';
import 'global_sized_box.dart';

class GlobalCompanyInfoWidget extends StatelessWidget {
  final String? companyName;
  final String? companyDescription;
  final String? phone;
  final String? email;
  final String? address;
  final Color? primaryColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const GlobalCompanyInfoWidget({
    super.key,
    this.companyName,
    this.companyDescription,
    this.phone,
    this.email,
    this.address,
    this.primaryColor,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final Color appColor = primaryColor ?? Theme.of(context).primaryColor;

    return Container(
      width: double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 12),
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: appColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.business_rounded,
                  color: appColor,
                  size: 16,
                ),
              ),
              sizedBoxW(8),
              const Text(
                "Company Information",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorRes.black,
                ),
              ),
            ],
          ),
          sizedBoxH(10),

          // Company Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  appColor.withValues(alpha: 0.05),
                  appColor.withValues(alpha: 0.02),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: appColor.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: ColorRes.appColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.business_center_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                sizedBoxW(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName ?? "Company Name",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      if (companyDescription != null) ...[
                        sizedBoxH(2),
                        Text(
                          companyDescription!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF64748B),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          sizedBoxH(10),

          // Contact Information
          Column(
            children: [
              if (phone != null || email != null)
                Row(
                  children: [
                    if (phone != null)
                      Expanded(
                        flex: 2,
                        child: _buildContactCard(
                          icon: Icons.phone_rounded,
                          value: phone!,
                          color: ColorRes.greenAccent,
                        ),
                      ),
                    if (phone != null && email != null) const SizedBox(width: 6),
                    if (email != null)
                      Expanded(
                        flex: 3,
                        child: _buildContactCard(
                          icon: Icons.email_rounded,
                          value: email!,
                          color: ColorRes.blueAccent,
                        ),
                      ),
                  ],
                ),
              if ((phone != null || email != null) && address != null)
                sizedBoxH(6),
              if (address != null)
                _buildAddressCard(address!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Icon(
              icon,
              size: 12,
              color: color,
            ),
          ),
          sizedBoxW(5),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E293B),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(String address) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 0.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFFDC2626).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: const Icon(
              Icons.location_on_rounded,
              size: 12,
              color: ColorRes.redAccent,
            ),
          ),
          sizedBoxW(6),
          Expanded(
            child: Text(
              address,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E293B),
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
