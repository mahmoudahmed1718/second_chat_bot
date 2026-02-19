import 'package:flutter/material.dart';

class SuggestionCategory {
  final String title;
  final IconData icon;
  final List<String> items;

  const SuggestionCategory({
    required this.title,
    required this.icon,
    required this.items,
  });
}
