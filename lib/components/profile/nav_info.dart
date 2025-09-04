import 'package:flutter/material.dart';

class NavInfo {
  final String title;
  final String subtitle;
  final IconData icon;
  final String childRouteName;

  NavInfo({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.childRouteName,
  });
}
