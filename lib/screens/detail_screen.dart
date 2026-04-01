import 'package:flutter/material.dart';
import 'package:newssports/models/models.dart';

class DetailScreen extends StatelessWidget {
  final FactItem factItem;
  final Color categoryColor;

  const DetailScreen({
    super.key,
    required this.factItem,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fact Details"),
        backgroundColor: categoryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              factItem.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                factItem.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    avatar: Icon(Icons.image_outlined, color: categoryColor, size: 18),
                    label: Text(factItem.imageAlt),
                    backgroundColor: categoryColor.withOpacity(0.12),
                    side: BorderSide.none,
                  ),
                  Chip(
                    avatar: Icon(Icons.auto_awesome, color: categoryColor, size: 18),
                    label: const Text('Fun Fact'),
                    backgroundColor: categoryColor.withOpacity(0.12),
                    side: BorderSide.none,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                factItem.fact,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  factItem.spotlight,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: categoryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'More Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: categoryColor,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                factItem.details,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.7,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
