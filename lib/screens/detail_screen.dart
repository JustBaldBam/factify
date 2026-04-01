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
            // IMAGE
            Image.network(
              factItem.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 16),

            // TITLE (imageAlt)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                factItem.imageAlt,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // FACT TEXT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                factItem.fact,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.5,
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
