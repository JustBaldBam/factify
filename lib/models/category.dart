// lib/models/category.dart
import 'package:flutter/material.dart';

class FactItem {
  final String fact;
  final String imageUrl;
  final String imageAlt;

  FactItem({
    required this.fact,
    this.imageUrl = "",
    this.imageAlt = "",
  });
}

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  // Find category by ID from the global list
  static Category? findById(String id, List<Category> categories) {
    try {
      return categories.firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }
}