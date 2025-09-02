import 'package:flutter/material.dart';

class PageItem {
  final String label;
  final IconData icon;
  final WidgetBuilder builder;

  PageItem({
    required this.label,
    required this.icon,
    required this.builder,
  });
}