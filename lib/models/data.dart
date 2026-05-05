import 'package:flutter/material.dart';

import 'category.dart';

enum AppTab { home, search, ai, saved, profile }

enum AiChatRole { user, assistant }

class AiChatMessage {
  final AiChatRole role;
  final String content;

  const AiChatMessage({
    required this.role,
    required this.content,
  });

  AiChatMessage copyWith({
    AiChatRole? role,
    String? content,
  }) {
    return AiChatMessage(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }
}

class FactItem {
  final int? id;
  final String fact;
  final String categoryId;
  final String imageAlt;
  final String imageUrl;
  final List<String> imageUrls;
  final String title;
  final String details;
  final String spotlight;

  const FactItem({
    this.id,
    required this.fact,
    required this.categoryId,
    required this.imageAlt,
    required this.imageUrl,
    required this.imageUrls,
    required this.title,
    required this.details,
    required this.spotlight,
  });

  factory FactItem.fromJson(Map<String, dynamic> json) {
    final fact = (json['fact'] ?? '').toString().trim();
    final categoryId = (json['fact_type'] ?? json['category_id'] ?? 'random')
        .toString()
        .trim()
        .toLowerCase();
    final details = (json['fact_info'] ?? json['details'] ?? '')
        .toString()
        .trim();
    final imageUrls = [
      json['image_url'],
      json['img1'],
      json['img2'],
      json['img3'],
    ]
        .map((value) => (value ?? '').toString().trim())
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList();

    return FactItem(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}'),
      fact: fact,
      categoryId: categoryId,
      imageAlt: _buildImageAlt(categoryId, fact),
      imageUrl: imageUrls.isNotEmpty ? imageUrls.first : '',
      imageUrls: imageUrls,
      title: _buildTitle(fact),
      details: details.isNotEmpty ? details : 'More details coming soon.',
      spotlight: _buildSpotlight(details, fact),
    );
  }
}

class RandomFactData {
  final String fact;
  final String categoryId;

  const RandomFactData({
    required this.fact,
    required this.categoryId,
  });
}

class FactStoreData {
  final List<Category> categories;
  final Map<String, List<FactItem>> factDataStore;

  const FactStoreData({
    required this.categories,
    required this.factDataStore,
  });

  List<String> get dailyFacts => factDataStore.values
      .expand((facts) => facts)
      .take(5)
      .map((fact) => fact.fact)
      .toList();
}

final Map<String, IconData> _categoryIcons = {
  'science': Icons.science,
  'animals': Icons.pets,
  'christmas': Icons.star,
  'history': Icons.schedule,
  'space': Icons.rocket_launch,
  'technology': Icons.computer,
  'random': Icons.casino,
};

final Map<String, Color> _categoryColors = {
  'science': Colors.blue.shade600,
  'animals': Colors.green.shade600,
  'christmas': Colors.red.shade700,
  'history': Colors.yellow.shade700,
  'space': Colors.purple.shade700,
  'technology': Colors.cyan.shade600,
  'random': Colors.orange.shade600,
};

Category buildCategory(String id, {String? name}) {
  final normalizedId = id.trim().toLowerCase();
  return Category(
    id: normalizedId,
    name: name?.trim().isNotEmpty == true ? name!.trim() : _titleCase(normalizedId),
    icon: _categoryIcons[normalizedId] ?? Icons.category,
    color: _categoryColors[normalizedId] ?? Colors.indigo.shade600,
  );
}

Map<String, List<FactItem>> groupFactsByCategory(List<FactItem> facts) {
  final Map<String, List<FactItem>> groupedFacts = {};
  for (final fact in facts) {
    groupedFacts.putIfAbsent(fact.categoryId, () => []).add(fact);
  }
  return groupedFacts;
}

RandomFactData getRandomFactFromStore(Map<String, List<FactItem>> factDataStore) {
  final allFacts = factDataStore.values.expand((list) => list).toList();
  if (allFacts.isEmpty) {
    return const RandomFactData(fact: 'No facts available!', categoryId: 'none');
  }

  final randomFact = allFacts[DateTime.now().millisecond % allFacts.length];
  return RandomFactData(
    fact: randomFact.fact,
    categoryId: randomFact.categoryId,
  );
}

String _buildImageAlt(String categoryId, String fact) {
  if (fact.isEmpty) {
    return _titleCase(categoryId);
  }

  final cleaned = fact.replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '').trim();
  if (cleaned.isEmpty) {
    return _titleCase(categoryId);
  }

  final words = cleaned.split(RegExp(r'\s+')).take(4).join(' ');
  return words;
}

String _buildTitle(String fact) {
  if (fact.isEmpty) {
    return 'Fun Fact';
  }

  final cleaned = fact.replaceAll(RegExp(r'[.!?]+$'), '').trim();
  final words = cleaned.split(RegExp(r'\s+')).take(7).join(' ');
  return words;
}

String _buildSpotlight(String details, String fact) {
  if (details.isNotEmpty) {
    return details;
  }

  if (fact.isNotEmpty) {
    return fact;
  }

  return 'A fun fact worth sharing.';
}

String _titleCase(String value) {
  return value
      .split(RegExp(r'[_\s-]+'))
      .where((part) => part.isNotEmpty)
      .map(
        (part) => '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}',
      )
      .join(' ');
}
