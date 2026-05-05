import 'package:flutter/material.dart';
import 'package:newssports/models/data.dart';

class RandomFactModal extends StatelessWidget {
  final RandomFactData fact;
  final VoidCallback onClose;

  const RandomFactModal({super.key, required this.fact, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: onClose,
              ),
            ),
            Icon(Icons.flash_on, size: 40, color: Colors.indigo.shade600), 
            const SizedBox(height: 8),
            const Text(
              'Random Fact!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
            ),
            Text(
              '${fact.categoryId} Category'.toUpperCase(),
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.indigo.shade100),
              ),
              child: Text(
                fact.fact,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onClose,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade600, 
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                minimumSize: const Size(double.infinity, 48),
                elevation: 4,
              ),
              child: const Text('Got It!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
