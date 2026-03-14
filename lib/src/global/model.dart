import 'package:flutter/material.dart';

class GlobalModel{
  String src;
  GlobalModel({required this.src});
}

class GlobalMenuModel{
  GlobalMenuModel({
    required this.img,
    required this.color,
    required this.text,
    required this.slug
  });
  String img;
  Color color;
  String text;
  String slug;
}

class BottomModel{}


class AdminGlobalModel {
  String src;
  AdminGlobalModel({required this.src});
}

class AdminGlobalMenuModel {
  IconData icon;
  Color color;
  String text;

  AdminGlobalMenuModel({
    required this.icon,
    required this.color,
    required this.text,
  });
}