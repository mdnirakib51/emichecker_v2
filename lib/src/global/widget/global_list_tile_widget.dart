
import 'package:flutter/material.dart';
import '../constants/colors_resources.dart';
import 'global_text.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final void Function()? onTap;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
      minLeadingWidth: 0,
      onTap: onTap,
      title: GlobalText(
        str: title,
        color: ColorRes.deep300,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        overflow: TextOverflow.ellipsis,
      ),
      trailing: trailing,
    );
  }
}

class CustomIconListTile extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final void Function()? onTap;

  const CustomIconListTile({
    super.key,
    this.title,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title ?? ''),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}

class CustomSubListTile extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final IconData? icon;
  final Color? iconColor;
  final void Function()? onTap;

  const CustomSubListTile({
    super.key,
    this.title,
    this.subTitle,
    this.icon,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title ?? '', style: const TextStyle(fontSize: 14, color: ColorRes.white)),
        leading: Icon(icon, size: 25, color: iconColor
        ),
        onTap: onTap,
        subtitle: Text(subTitle ?? '', style: const TextStyle(fontSize: 12, color: ColorRes.grey),
        ));
  }
}

class GlobalListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Widget? trailing;

  const GlobalListTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.iconColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: (iconColor ?? ColorRes.appColor).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor ?? ColorRes.appColor,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ColorRes.deep400,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle!,
        style: const TextStyle(
          fontSize: 14,
          color: ColorRes.textColor,
        ),
      )
          : null,
      trailing: trailing,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
