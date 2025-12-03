import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  final List<Map<String, dynamic>> savedFacts;
  final Function(String categoryId) onCategorySelect;

  const SavedScreen({super.key, required this.savedFacts, required this.onCategorySelect});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Saved Facts',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
            ),
          ),
          Text(
            'You have saved ${savedFacts.length} amazing facts.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 24),
          if (savedFacts.isEmpty)
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
              ),
              child: Column(
                children: [
                  Icon(Icons.favorite, size: 40, color: Colors.red.shade400),
                  const SizedBox(height: 12),
                  const Text('Nothing saved yet!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => onCategorySelect('random'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                    ),
                    child: const Text('Find Facts Now', style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: savedFacts.length,
              itemBuilder: (context, index) {
                final factItem = savedFacts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                factItem['fact'],
                                style: TextStyle(fontSize: 16, color: Colors.grey.shade700, height: 1.5),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Category: ${factItem['categoryId']}',
                                style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
        ],
      ),
    );
  }
}