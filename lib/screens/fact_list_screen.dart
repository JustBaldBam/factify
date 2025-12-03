import 'package:flutter/material.dart';
import 'package:newssports/models/category.dart';
import 'package:newssports/models/mock_data.dart';
import '../widgets/fact_card.dart';

class FactListScreen extends StatelessWidget {
  final String categoryId;
  final VoidCallback onBackToCategories;

  const FactListScreen({
    super.key,
    required this.categoryId,
    required this.onBackToCategories,
  });

  @override
  Widget build(BuildContext context) {
    // Find the category object
    final Category? category = Category.findById(categoryId, categories);
    final List<FactItem> facts = factDataStore[categoryId] ?? [];

    // Safety check
    if (category == null || facts.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onBackToCategories,
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                "Category not found!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    // Colors for the AppBar gradient
    final Color baseColor = category.color;
    final Color darker = Color.alphaBlend(Colors.black.withOpacity(0.3), baseColor);
    final Color lighter = Color.alphaBlend(Colors.white.withOpacity(0.3), baseColor);


    return CustomScrollView(
      slivers: [
        // AppBar with Collapsing Header and Gradient Background
        SliverAppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBackToCategories,
          ),
          expandedHeight: 200.0, // Height of the header
          pinned: true, // App bar remains visible
          surfaceTintColor: baseColor,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(bottom: 16),
            title: Text(
              category.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
              ),
            ),
            centerTitle: true,
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [darker, baseColor, lighter],
                ),
              ),
              child: Center(
                child: Icon(
                  category.icon,
                  size: 80,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
          ),
        ),

        // Facts List
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final factItem = facts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FactCard(
                    factItem: factItem,
                    categoryColor: baseColor,
                  ),
                );
              },
              childCount: facts.length,
            ),
          ),
        ),
      ],
    );
  }
}