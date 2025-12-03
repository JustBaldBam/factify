import 'package:flutter/material.dart';
import '../models/category.dart';

class FactCard extends StatelessWidget {
  final FactItem factItem;
  final Color categoryColor;

  const FactCard({super.key, required this.factItem, required this.categoryColor});

  String _getPlaceholderUrl(String text) {
    final sanitizedText = text.replaceAll(' ', '+');
    // Generates a wide placeholder image with light background and dark text, using the imageAlt
    return 'https://placehold.co/1200x400/F3F4F6/1F2937?text=$sanitizedText';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.indigo.shade50),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.25), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      clipBehavior: Clip.antiAlias, // Ensures children respect the rounded corners
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Image Placeholder
          SizedBox(
            height: 150,
            child: Image.network(
              _getPlaceholderUrl(factItem.imageAlt),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback for network issues: simple colored container
                return Container(
                  color: categoryColor.withOpacity(0.2),
                  child: Center(
                    child: Text(
                      factItem.imageAlt, 
                      textAlign: TextAlign.center,
                      style: TextStyle(color: categoryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // 2. Fact Content and Details
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
                const SizedBox(height: 16),
                
                // Action buttons (Placeholder for saving/sharing)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      // Placeholder for save action
                    },
                    icon: Icon(Icons.bookmark_border, size: 20, color: Colors.indigo.shade400),
                    label: Text('Save Fact', style: TextStyle(color: Colors.indigo.shade400, fontWeight: FontWeight.w600)),
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