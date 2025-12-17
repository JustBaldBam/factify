
import 'package:flutter/material.dart';
import '../models/category.dart';

class FactCard extends StatelessWidget {
  final FactItem factItem;
  final Color categoryColor;
  final String categoryId;
  final Function(String fact, String categoryId) onSaveFact;

  const FactCard({
    super.key,
    required this.factItem,
    required this.categoryColor,
    required this.categoryId,
    required this.onSaveFact,
  });

  String _getPlaceholderUrl(String text) {
    final sanitizedText = text.replaceAll(' ', '+');
    return 'https://placehold.co/1200x400/F3F4F6/1F2937?text=$sanitizedText';
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = factItem.imageUrl.isNotEmpty
        ? factItem.imageUrl
        : _getPlaceholderUrl(factItem.imageAlt);

    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.indigo.shade50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 150,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey.shade200,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: categoryColor.withOpacity(0.2),
                  child: Center(
                    child: Text(
                      factItem.imageAlt,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: categoryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, size: 20, color: categoryColor),
                    const SizedBox(width: 8),
                    Text(
                      'Did You Know?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: categoryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  factItem.fact,
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade800, height: 1.5),
                ),
                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      onSaveFact(factItem.fact, categoryId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Fact saved successfully! 🎉'),
                          backgroundColor: Colors.indigo.shade600,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(Icons.bookmark_border, size: 22, color: Colors.indigo.shade600),
                    label: Text(
                      'Save Fact',
                      style: TextStyle(color: Colors.indigo.shade600, fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}