// lib/screens/category_screen.dart
import 'package:flutter/material.dart';
import '../models/models.dart';

class CategoryScreen extends StatelessWidget {
  final List<Category> categories;
  final Function(String?) onCategorySelect;

  const CategoryScreen({
    super.key,
    required this.categories,
    required this.onCategorySelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            // Factify Logo + Text (exactly like your design)
            Icon(
              Icons.lightbulb_outline_rounded,
              color: Colors.indigo.shade600,
              size: 30,
            ),
            const SizedBox(width: 10),
            Text(
              "Factify",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.indigo.shade700,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          // Search Icon Button (right corner)
          IconButton(
            onPressed: () {
              // Open search or show dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Search feature coming soon!")),
              );
            },
            icon: Icon(
              Icons.search_rounded,
              size: 28,
              color: Colors.indigo.shade600,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.85,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

            return GestureDetector(
              onTap: () => onCategorySelect(category.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: category.color, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: category.color.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category.icon, size: 32, color: category.color),
                    const SizedBox(height: 6),
                    Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w900,
                        color: category.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}